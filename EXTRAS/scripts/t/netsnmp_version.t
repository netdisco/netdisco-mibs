#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use File::Temp 'tempdir';
use File::Spec::Functions qw(catfile catdir);
use FindBin;

BEGIN { $ENV{MIBHOME} //= catdir($FindBin::Bin, '..', '..', '..') }
use lib catdir($FindBin::Bin, '..', 'lib');
use Helpers;

sub path_with_fake_snmptranslate {
  my $output = shift;
  my $dir = tempdir(CLEANUP => 1);
  my $script = catfile($dir, 'snmptranslate');
  open my $fh, '>', $script or die "cannot write $script: $!";
  print $fh "#!/bin/sh\necho '$output'\n";
  close $fh;
  chmod 0755, $script;
  return $dir;
}

subtest 'netsnmp_version__snmptranslate_on_path__returns_reported_version' => sub {
  local $ENV{PATH} = path_with_fake_snmptranslate('NET-SNMP version: 5.9.5.2');
  is netsnmp_version(), '5.9.5.2';
};

subtest 'netsnmp_version__prerelease_suffix__returns_full_version_string' => sub {
  local $ENV{PATH} = path_with_fake_snmptranslate('NET-SNMP version: 5.9.4.pre1');
  is netsnmp_version(), '5.9.4.pre1';
};

subtest 'netsnmp_version__no_snmptranslate_on_path__returns_undef' => sub {
  local $ENV{PATH} = tempdir(CLEANUP => 1);
  is netsnmp_version(), undef;
};

subtest 'netsnmp_version__unrecognized_output__returns_undef' => sub {
  local $ENV{PATH} = path_with_fake_snmptranslate('something else entirely');
  is netsnmp_version(), undef;
};

subtest 'netsnmp_version_at_least__compares_numerically_by_component' => sub {
  ok  netsnmp_version_at_least('5.9.1',      '5.9.1'), 'equal';
  ok  netsnmp_version_at_least('5.9.5.2',    '5.9.1'), 'longer and newer';
  ok  netsnmp_version_at_least('5.10',       '5.9.1'), 'two-digit minor';
  ok  netsnmp_version_at_least('5.9.4.pre1', '5.9.1'), 'prerelease suffix ignored';
  ok !netsnmp_version_at_least('5.9',        '5.9.1'), 'shorter is older';
  ok !netsnmp_version_at_least('5.8',        '5.9.1'), 'older minor';
};

subtest 'netsnmp_version_at_least__undefined_version__is_false' => sub {
  ok !netsnmp_version_at_least(undef, '5.9.1');
};

done_testing;
