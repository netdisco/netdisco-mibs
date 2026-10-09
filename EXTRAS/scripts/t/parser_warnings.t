#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use File::Spec::Functions 'catdir';
use FindBin;

BEGIN { $ENV{MIBHOME} //= catdir($FindBin::Bin, '..', '..', '..') }
use lib catdir($FindBin::Bin, '..', 'lib');
use Helpers;

my $dup_object = "Duplicate Object 'des3200-10' at line 60 in /m/d-link/x.mib. First at line 45\n";
my $dup_enum   = "Duplicate enum label 'byte' at line 550 in /m/cisco/y.my. First at line 549\n";
my $dup_tc     = "Duplicate TEXTUAL-CONVENTION 'Foo' at line 9 in /m/z.my. First at line 3\n";
my $fatal      = "Cannot find module (NO-SUCH-MIB): At line 4 in /m/a.mib\n";

subtest 'split_parser_warnings__only_duplicate_definitions__all_warnings_no_errors' => sub {
  my ($warnings, $errors) = Helpers::split_parser_warnings($dup_object . $dup_enum . $dup_tc);
  is $warnings, $dup_object . $dup_enum . $dup_tc;
  is $errors, '';
};

subtest 'split_parser_warnings__other_message__kept_as_error' => sub {
  my ($warnings, $errors) = Helpers::split_parser_warnings($fatal);
  is $warnings, '';
  is $errors, $fatal;
};

subtest 'split_parser_warnings__mixed__separates_each_line' => sub {
  my ($warnings, $errors) = Helpers::split_parser_warnings($dup_object . $fatal . $dup_enum);
  is $warnings, $dup_object . $dup_enum;
  is $errors, $fatal;
};

subtest 'split_parser_warnings__empty_or_undef__both_empty' => sub {
  is_deeply [Helpers::split_parser_warnings('')], ['', ''];
  is_deeply [Helpers::split_parser_warnings(undef)], ['', ''];
};

subtest 'split_parser_warnings__duplicate_text_mid_line__kept_as_error' => sub {
  my $line = "Unlinked OID: Duplicate Object 'x' at line 1 in f. First at line 1\n";
  my ($warnings, $errors) = Helpers::split_parser_warnings($line);
  is $warnings, '';
  is $errors, $line;
};

done_testing;
