package Helpers;

use strict;
use warnings;

use charnames ':full';
binmode STDOUT, ':utf8';

use File::Temp;
use File::Copy;
use File::Spec::Functions qw(splitdir catfile);
use Term::ANSIColor qw(:constants);

use Exporter 'import';
our @EXPORT = qw(status blank build_index parse_index2);

if (!defined $ENV{MIBHOME}) {
  print "error: must define \$MIBHOME (where the MIB dirs live)\n";
  exit(1);
}

# Force LC_COLLATE to ensure stable sorting routines during system calls
$ENV{"LC_COLLATE"} = 'C';

$ENV{SNMPCONFPATH} = '';
$ENV{SNMP_PERSISTENT_DIR} = "$ENV{MIBHOME}/EXTRAS/indexes";
$ENV{MIBS} = 'SNMPv2-MIB';
$ENV{MIBDIRS} = "$ENV{MIBHOME}/net-snmp:$ENV{MIBHOME}/rfc";

sub blank {
  print "\r\e[K"; # blank line
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
  print YELLOW, "$i ", CYAN, $note, RESET;
}

sub build_index {
  my ($bundle, $keep) = @_;
  my (%mib_for, %file_for);

  my $tmpdir = File::Temp->newdir();
  $ENV{SNMP_PERSISTENT_DIR} = $tmpdir->dirname;
  qx(snmptranslate -IR sysName 2>&1 >/dev/null);
  my $newmibdirs = $ENV{MIBDIRS} .":$bundle";
  qx(snmptranslate -M'$newmibdirs' -IR sysName 2>\&1 >/dev/null);
  $ENV{SNMP_PERSISTENT_DIR} = "$ENV{MIBHOME}/EXTRAS/indexes";

  # read the MIBs that net-snmp likes (file '2' is the vendor)
  # TODO: make this work also for rfc:net-snmp
  open(my $cache, '<', "$tmpdir/mib_indexes/2") or die $!;
  while (my $line = <$cache>) {
    next if $line =~ m/^DIR /;
    my ($mib, $file) = ($line =~ m/^(\S+)\s+(\S+)$/);

    # store mib-file mapping
    $mib_for{$file} = $mib;
    $file_for{$mib} = $file;
  }
  close $cache;

  # keep a copy of the mib index file to help the dev
  if ($keep) {
    mkdir(catfile($bundle, 'ignore'));
    copy("$tmpdir/mib_indexes/2", catfile($bundle, 'ignore', 'dotindex.txt'));
  }

  return (\%mib_for, \%file_for);
}

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
    if ($line =~ m/^VENDOR\s+(\S+)/) {
      $currvendor = (grep {m/\S/} splitdir($1))[-1];
      next;
    }
    my ($mib, $file) = ($line =~ m/^(\S+)\s+(\S+)$/);

    $oldfile_for{$mib} = $file;
    $vendor_for{$mib} = $currvendor;
    push @{$mibs_for{$currvendor}}, $mib;
    push @allmibs, $mib;
  }
  close $index;

  return (\%vendor_for, \%oldfile_for, \%mibs_for, \@allmibs);
}

1;
