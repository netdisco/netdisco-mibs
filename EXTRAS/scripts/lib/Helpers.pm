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
our @EXPORT = qw(status blank build_index mkindex);

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

# Scan all the MIBs in $ENV{MIBHOME} and return maps of:
#   file<->[MIBs], MIB<->[vendors], MIB<->[files], vendor->[files]
# $squawk to show warnings about strange things
sub mkindex {
  my $squawk = shift;
  my ($mib_files, $file_mibs, $mib_vendors, $vendors_mib);

  # TODO put rfc and net-snmp in different order?
  foreach my $vendor (sort map {(splitdir($_))[-1]} grep {-d} glob(catdir($ENV{MIBHOME},'*'))) {
    next if $vendor =~ m/^(?:EXTRAS)$/ or $vendor =~ m/\./;

    status($vendor);
    my ($mibs_for, $files_for) = build_index($vendor);

    foreach my $mib (keys %$files_for) {
      # hygiene check
      if ($squawk and (($mib !~ m/^[A-Z][A-Za-z0-9-]*$/) or ($mib =~ m/--/) or ($mib =~ m/-$/))) {
        blank();
        print YELLOW, "\N{WARNING SIGN} ", MAGENTA, $mib,
              CYAN, ' is named using invalid characters ',
              RESET, "(from $vendor/$files_for->{$mib}->[-1])\n";
        status($vendor);
      }

      push @{ $mib_files->{ $mib } },
           map { catfile($vendor, $_) } @{ $files_for->{$mib} };
    }
    map { push @{ $file_mibs->{ $_ } }, @{ $mibs_for->{$_} }  }
        keys %$mibs_for;
  }
  blank();

  # hygiene check
  if ($squawk) {
    foreach my $mib (keys %$mib_files) {
      next unless scalar @{ $mib_files->{$mib} } > 1;

      print YELLOW, "\N{WARNING SIGN} ", MAGENTA, $mib,
            CYAN, ' was defined ', (scalar @{ $mib_files->{$mib} }), ' times: ', RESET;

      my @vendors = map m{^([^/]+)}, @{ $mib_files->{$mib} };

      if (scalar keys %{{ map {$_, 1} @vendors }} == 1) {
        print 'all within vendor ', $vendors[0], "\n";
      }
      elsif (scalar grep {$_ eq 'rfc'} @vendors) {
        print "overridden by rfc\n";
      }
      else {
        print join ',', @{ $mib_files->{$mib} }; print "\n";
      }
    }
  }

  print "\N{HEAVY CHECK MARK} Cache rebuilt.\n";
}

1;
