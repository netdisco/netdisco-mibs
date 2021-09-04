package Helpers;

use strict;
use warnings;

use charnames ':full';
binmode STDOUT, ':utf8';

use File::Temp;
use File::Copy;
use Path::Tiny 'path';
use List::Util 'uniq';
use File::Spec::Functions qw(splitdir catfile catdir);
use Term::ANSIColor qw(:constants);
use Try::Tiny;

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

# Given a directory ($vendor) where some MIBs are waiting, grep them for
# DEFINITIONS statements to build a map of file<->[MIBs] and MIB<->[files]
sub build_index {
  my $vendor = shift;
  my (%file_mibs, %mib_files);
  return ({},{}) unless -d catdir($ENV{MIBHOME}, $vendor);

  foreach my $filepath (sort grep {-f} glob(catdir($ENV{MIBHOME}, $vendor, '*'))) {
    my $content = try { path($filepath)->slurp } or next;
    my $file = (splitdir($filepath))[-1];
    # could also use # @defs = qx(egrep '^\\s*\\w(\\w|-)+\\s+DEFINITIONS\\s*::=\\s*BEGIN' '$mibfile');
    my @matches = ( $content =~ m{ ([A-Za-z][\w-]*+) \s+ DEFINITIONS }xg );
    foreach my $mib (@matches) {
      push @{ $file_mibs{catfile($vendor, $file)} }, $mib;
      push @{ $mib_files{$mib} }, catfile($vendor, $file);
    }
  }

  return (\%file_mibs, \%mib_files);
}

# Scan all the MIBs in $ENV{MIBHOME} and return maps of:
#   file<->[MIBs], MIB<->[vendors], MIB<->[files], vendor->[files]
# $squawk to show warnings about strange things
sub mkindex {
  my $squawk = shift;
  my ($file_mibs, $mib_vendors, $mib_files, $vendor_files);

  # TODO put rfc and net-snmp in different order?
  foreach my $vendor (sort map {(splitdir($_))[-1]} grep {-d} glob(catdir($ENV{MIBHOME},'*'))) {
    next if $vendor =~ m/^(?:EXTRAS)$/ or $vendor =~ m/\./;

    status($vendor);
    my ($mibs_for, $files_for) = build_index($vendor);

    # MIB<->[files]
    map { push @{ $mib_files->{ $_ } }, @{ $files_for->{ $_ } } } keys %$files_for;
    # file<->[MIBs]
    map { push @{ $file_mibs->{ $_ } }, @{ $mibs_for->{ $_ } }  } keys %$mibs_for;
    # MIB<->[vendors]
    map { push @{ $mib_vendors->{ $_ } }, $vendor } keys %$files_for;
    # vendor->[files]
    push @{ $vendor_files->{ $vendor } }, keys %$mibs_for;
  }
  blank();

  # hygiene checks
  if ($squawk) {
    foreach my $mib (keys %$mib_files) {
      if (($mib !~ m/^[A-Z][A-Za-z0-9-]*$/) or ($mib =~ m/--/) or ($mib =~ m/-$/)) {
        print YELLOW, "\N{WARNING SIGN} ", MAGENTA, $mib,
              CYAN, ' is named using ', RESET, 'invalid characters ', CYAN, '(',
              join ',', @{ $mib_files->{$mib} }; print ')', RESET, "\n";
      }

      my @vendors = map m{^([^/]+)}, @{ $mib_files->{$mib} };
      next if scalar @vendors == 1;

      print YELLOW, "\N{WARNING SIGN} ", MAGENTA, $mib,
            CYAN, ' was ', RESET ,'defined ', (scalar @vendors), ' times ', CYAN;

      if ((scalar uniq @vendors) == 1) {
        print 'in vendor ', $vendors[0];
      }
      elsif (scalar grep {$_ eq 'rfc'} @vendors) {
        print 'overridden by rfc';
      }
      else {
        print join ',', @{ $mib_files->{$mib} };
      }
      print RESET, "\n";
    }
  }

  print "\N{HEAVY CHECK MARK} Cache rebuilt.\n";
  # use DDP; map {p $_} ($file_mibs, $mib_vendors, $mib_files, $vendor_files);
  return ($file_mibs, $mib_vendors, $mib_files, $vendor_files);
}

1;
