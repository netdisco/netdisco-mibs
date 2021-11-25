package Helpers;

use strict;
use warnings;

use charnames ':full';
binmode STDOUT, ':utf8';

use Cwd 'realpath';
use File::Slurper 'read_text';
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

# Given a directory ($target) where some MIBs are waiting, grep them for
# DEFINITIONS statements to build a map of file->MIB and MIB<->[files]
# also works when given a plain MIB file.
# Will bomb when MIB name has illegal chars,
#                or file has multiple MIB defs
#                or MIB is defined multiple times in the bundle
sub build_index {
  my $target = shift;
  my %mib_file;
  my $errors = 0;

  my %files = (-f $target ? ($target => $target)
    : ( map {catfile( (splitdir($_))[-2,-1] ) => $_} grep {-f} glob(catdir(realpath($target), '*')) ));

  foreach my $fileref (sort keys %files) {
    my $filepath = $files{$fileref};
    my $content = try { read_text($filepath, 'latin1') } or next;
    $content =~ s/ ^ \s* -- .* $ //mxg;

    my @matches = ( $content =~ m{  \s* ([A-Za-z][\w-]*+) \s+ DEFINITIONS \s* ::= \s* BEGIN }mxg );
    next unless scalar @matches;

    if (scalar @matches > 1) {
      blank();
      print RED, "\N{HEAVY BALLOT X} error: ", MAGENTA, $filepath, CYAN,
        ' contains multiple MIB DEFINITIONS: ', RESET, (join ',', @matches), "\n";
      ++$errors;
    }

    my $mib = $matches[0];
    if (($mib !~ m/^[A-Z][A-Za-z0-9-]*$/) or ($mib =~ m/--/) or ($mib =~ m/-$/)) {
      blank();
      print RED, "\N{HEAVY BALLOT X} error: ", MAGENTA, $mib, CYAN,
        ' is named using invalid characters in ', RESET, $filepath, "\n";
      ++$errors;
    }

    if (exists $mib_file{$mib}) {
      blank();
      print RED, "\N{HEAVY BALLOT X} error: ", MAGENTA, $mib;

      my $oldfile = $files{ $mib_file{$mib} };
      my $diff = qx(diff -q -b -B -w '$oldfile' '$filepath' 2>/dev/null);
      if ($diff =~ m/^\s*$/) {
        print CYAN, ' from ', RESET, $mib_file{$mib},
              CYAN, ' is redefined identically in ', RESET "$filepath\n";
      }
      else {
        print CYAN, ' defined differently:', CLEAR, FAINT;
        print "\n\tdiff -b -B -w --strip-trailing-cr '$oldfile' '$filepath' | less\n", RESET;
      }

      ++$errors;
      next; # do not overwrite "original" module definition
    }

    $mib_file{$mib} = $fileref;
  }

  #use DDP; p %mib_file; p $errors;
  return (\%mib_file, $errors);
}

# Scan all the MIBs in $ENV{MIBHOME} and return maps of:
#   file->MIB, MIB->[files], vendor->[MIBs], MIB->[vendors]
sub mkindex {
  my ($mib_for_file, $mib_files, $vendor_mibs, $mib_vendors) = ({}, {}, {}, {});
  my $errors = 0;

  # TODO put rfc and net-snmp in different order?
  foreach my $vendor (map {(splitdir($_))[-1]} grep {-d} glob(catdir($ENV{MIBHOME},'*'))) {
    next if $vendor =~ m/^(?:EXTRAS)$/ or $vendor =~ m/\./;

    status($vendor);
    my ($file_for, $err) = build_index(catdir($ENV{MIBHOME}, $vendor));
    $errors += $err;

    # file->MIB
    $mib_for_file = { %$mib_for_file, reverse %$file_for };

    # MIB->[files]
    map { push @{ $mib_files->{ $_ } }, $file_for->{$_} } keys %$file_for;

    # vendor->[MIBs]
    $vendor_mibs->{$vendor} = [ sort {$a cmp $b} keys %$file_for ];

    # MIB->[vendors]
    map { push @{ $mib_vendors->{ $_ } }, $vendor } keys %$file_for;
  }
  blank();

  # clean up the lookup values
  foreach my $mib (keys %$mib_files) {
    $mib_files->{$mib} = [sort {$a cmp $b} @{ $mib_files->{$mib} }];
  }

  printf "\N{HEAVY CHECK MARK} Index rebuilt (%s errors, %s vendors, %s mibs).\n",
    $errors, (scalar keys %$vendor_mibs), (scalar keys %$mib_for_file);

  exit(1) if $errors;

  #use DDP; map {p $_} ($mib_for_file, $vendor_mibs, $mib_vendors);
  return ($mib_for_file, $mib_files, $vendor_mibs, $mib_vendors);
}

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

1;
