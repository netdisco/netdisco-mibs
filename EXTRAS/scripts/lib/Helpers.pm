package Helpers;

use strict;
use warnings;

use charnames ':full';
binmode STDOUT, ':utf8';

use File::Temp;
use File::Copy;
use Path::Tiny 'path';
use File::Spec::Functions qw(splitdir catfile catdir);
use Term::ANSIColor qw(:constants);
use Try::Tiny;
use DDP; #FIXME

use Exporter 'import';
our @EXPORT = qw(status blank build_index mkindex parse_index2);

if (!defined $ENV{MIBHOME}) {
  print "error: must define \$MIBHOME (where the MIB dirs live)\n";
  exit(1);
}

# Force LC_COLLATE to ensure stable sorting routines during system calls
$ENV{LC_COLLATE} = 'C';

$ENV{SNMPCONFPATH} = '';
$ENV{SNMP_PERSISTENT_DIR} = catdir($ENV{MIBHOME}, 'EXTRAS', 'indexes');
$ENV{MIBS} = 'SNMPv2-MIB';
$ENV{MIBDIRS} = catdir($ENV{MIBHOME}, 'net-snmp') .':'. catdir($ENV{MIBHOME}, 'rfc');

sub blank {
  select((select(STDOUT), $|=1)[0]);
  print "\r\e[K"; # blank line
}

my $i = undef;
sub status {
  my $note = (shift || '');
  my %spinner = (
    "\N{BRAILLE PATTERN DOTS-2345678}" => "\N{BRAILLE PATTERN DOTS-1235678}",
    "\N{BRAILLE PATTERN DOTS-1235678}" => "\N{BRAILLE PATTERN DOTS-1234678}",
    "\N{BRAILLE PATTERN DOTS-1234678}" => "\N{BRAILLE PATTERN DOTS-1234578}",
    "\N{BRAILLE PATTERN DOTS-1234578}" => "\N{BRAILLE PATTERN DOTS-1234567}",
    "\N{BRAILLE PATTERN DOTS-1234567}" => "\N{BRAILLE PATTERN DOTS-1234568}",
    "\N{BRAILLE PATTERN DOTS-1234568}" => "\N{BRAILLE PATTERN DOTS-1245678}",
    "\N{BRAILLE PATTERN DOTS-1245678}" => "\N{BRAILLE PATTERN DOTS-1345678}",
    "\N{BRAILLE PATTERN DOTS-1345678}" => "\N{BRAILLE PATTERN DOTS-2345678}"
  );
  $i = (!defined $i) ? "\N{BRAILLE PATTERN DOTS-2345678}" : $spinner{$i};
  blank();
  select((select(STDOUT), $|=1)[0]);
  print YELLOW, "$i ", CYAN, $note, RESET;
}

# Given a directory ($bundle) where some MIBs are waiting, grep them for
# DEFINITIONS statements to build a map of MIB<->[files] and file<->[MIBs]
sub build_index {
  my $bundle = shift;
  my (%mibs_for, %files_for);
  return ({},{}) unless -d catdir($ENV{MIBHOME}, $bundle);

  foreach my $filepath (sort grep {-f} glob(catdir($ENV{MIBHOME}, $bundle, '*'))) {
    my $content = try { path($filepath)->slurp } or next;
    my $file = (splitdir($filepath))[-1];
    # could also use # @defs = qx(egrep '^\\s*\\w(\\w|-)+\\s+DEFINITIONS\\s*::=\\s*BEGIN' '$mibfile');
    my @matches = ( $content =~ m{ ([A-Za-z][\w-]*+) \s+ DEFINITIONS }xg );
    foreach my $mib (@matches) {
      push @{ $mibs_for{$file} }, $mib;
      push @{ $files_for{$mib} }, $file;  # yeah, trust issues
    }
  }

  return (\%mibs_for, \%files_for);
}

sub mkindex {
  my ($rebuild, $strict) = @_;
  return if !$rebuild and -f catfile($ENV{SNMP_PERSISTENT_DIR}, 'mib_index2.txt');

  open(my $mibindex2, '>', catfile($ENV{SNMP_PERSISTENT_DIR}, 'mib_index2.txt')) or die $!;
  print $mibindex2 "MIB Index v2\n";
  my $all_mibs_files = {};

  # TODO put rfc and net-snmp in different order?
  foreach my $vendor (sort map {(splitdir($_))[-1]} grep {-d} glob(catdir($ENV{MIBHOME},'*'))) {
    next if $vendor =~ m/^(?:EXTRAS)$/ or $vendor =~ m/\./;
    status($vendor);

    print $mibindex2 "\nVENDOR $vendor\n";
    my ($mibs_for, $files_for) = build_index($vendor);

    foreach my $mib (keys %$files_for) {
      # hygiene check
      if (($mib !~ m/^[A-Z][A-Za-z0-9-]*$/) or ($mib =~ m/--/) or ($mib =~ m/-$/)) {
        blank();
        print YELLOW, "\N{WARNING SIGN} ", MAGENTA, $mib,
              CYAN, ' is named using invalid characters ',
              RESET, "(from $vendor/$files_for->{$mib}->[-1])\n";
        status($vendor);
        return ({},{}) if $strict;
      }

      # TODO check prescedence order of net-snmp when loading
      print $mibindex2 "$mib $files_for->{$mib}->[-1]\n";

      push @{ $all_mibs_files->{ $mib } },
           map { catfile($vendor, $_) } @{ $files_for->{$mib} };
    }
  }

  close $mibindex2;
  blank();

  # hygiene check
  foreach my $mib (keys %$all_mibs_files) {
    next unless scalar @{ $all_mibs_files->{$mib} } > 1;

    print YELLOW, "\N{WARNING SIGN} ", MAGENTA, $mib,
          CYAN, ' was defined ', (scalar @{ $all_mibs_files->{$mib} }), ' times: ', RESET;

    my @vendors = map m{^([^/]+)}, @{ $all_mibs_files->{$mib} };

    if (scalar keys %{{ map {$_, 1} @vendors }} == 1) {
      print 'all within vendor ', $vendors[0], "\n";
    }
    elsif (scalar grep {$_ eq 'rfc'} @vendors) {
      print "overridden by rfc\n";
    }
    else {
      print join ',', @{ $all_mibs_files->{$mib} }; print "\n";
    }
  }

  print "\N{HEAVY CHECK MARK} Cache rebuilt.\n";
}

# Read the netdisco-mibs mib_index2.txt file and return all the data within.
# maps of: MIB<->file, MIB<->vendor, vendor<->[MIBs]
#   also a list of all MIBs known to netdisco-mibs
sub parse_index2 {
  my $indexfile = catfile($ENV{SNMP_PERSISTENT_DIR}, 'mib_index2.txt');
  if (! -f $indexfile) {
    print "error: missing mib_index2.txt (run mkindex)\n";
    exit(1);
  }

  # load mib_index2.txt mapping all current known MIBs
  my (%vendor_for, %oldfile_for, %mibs_for, @allmibs, $currvendor);
  open(my $index, '<', $indexfile) or die $!;
  while (my $line = <$index>) {
    next if $line =~ m/^MIB Index/ or $line =~ m/^\s*$/;
    if ($line =~ m/^VENDOR\s+(.+)/) {
      $currvendor = (grep {m/\S/} splitdir($1))[-1];
      next;
    }
    my ($mib, $file) = ($line =~ m/^(\S+)\s+(.+)/);

    $oldfile_for{$mib} = $file;
    $vendor_for{$mib} = $currvendor;
    push @{$mibs_for{$currvendor}}, $mib;
    push @allmibs, $mib;
  }
  close $index;

  return (\%vendor_for, \%oldfile_for, \%mibs_for, \@allmibs);
}

1;
