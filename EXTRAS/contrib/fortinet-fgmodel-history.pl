#!/usr/bin/env perl
#
# Builds a per-fgModel.<number> name history from the git history of a MIB file.
#
# Default target file: fortinet/fortinet-fortigate-mib.mib
#
# Examples:
#   - Show only numbers whose name changed at least once:
#       perl EXTRAS/contrib/fortinet-fgmodel-history.pl --only-changes
#
#   - Restrict to a subset of model numbers:
#       perl EXTRAS/contrib/fortinet-fgmodel-history.pl --numbers 646,2012
#

use strict;
use warnings;

use Getopt::Long;
use Encode qw(encode);

binmode STDOUT, ':utf8';
$|++;

my $opt_repo   = '.';
my $opt_file   = 'fortinet/fortinet-fortigate-mib.mib';
my $opt_only   = 0;
my $opt_numbers;
my $opt_limit;

GetOptions(
  'repo=s'       => \$opt_repo,
  'file=s'       => \$opt_file,
  'only-changes' => \$opt_only,
  'numbers=s'    => \$opt_numbers,
  'limit=i'      => \$opt_limit,
) or die "Invalid options.\n";

my %numbers_filter;
my $have_filter = 0;
if (defined $opt_numbers && length $opt_numbers) {
  for my $tok (split /,/, $opt_numbers) {
    $tok =~ s/^\s+|\s+$//g;
    next unless length $tok;
    $tok =~ /^(\d+)$/ or die "--numbers must be a comma-separated list of integers\n";
    $numbers_filter{$1} = 1;
  }
  $have_filter = 1 if %numbers_filter;
}

my ($history, $final_map) = build_history($opt_repo, $opt_file);

my $printed = 0;
for my $number (sort { $a <=> $b } keys %{$history}) {
  next if $have_filter && !$numbers_filter{$number};
  my $events = $history->{$number};

  if ($opt_only) {
    my @distinct;
    for my $e (@{$events}) {
      push @distinct, $e->{name} if !@distinct || $distinct[-1] ne $e->{name};
    }
    next if @distinct <= 1;
  }

  print "fgModel.$number:\n";
  for my $e (@{$events}) {
    my $short = substr($e->{commit}{sha}, 0, 7);
    print "  - $e->{commit}{date_iso} ($short): $e->{name}\n";
  }
  $printed++;
  last if defined $opt_limit && $printed >= $opt_limit;
}

if ($printed == 0) {
  if ($have_filter) {
    my @n = sort { $a <=> $b } keys %numbers_filter;
    print 'No matching fgModel numbers found or no changes for: ', join(', ', @n), "\n";
  } else {
    print "No fgModel entries found.\n";
  }
}

exit 0;


sub build_history {
  my ($repo_root, $path) = @_;
  my $commits = get_commits_affecting_path($repo_root, $path);

  my %history;
  my %previous_mapping;

  for my $c (@{$commits}) {
    my $text = read_file_at_commit($repo_root, $c->{sha}, $path);
    my $current_mapping = parse_fgmodel_mapping($text);

    for my $number (sort { $a <=> $b } keys %{$current_mapping}) {
      my $name = $current_mapping->{$number};
      my $prev = $previous_mapping{$number};
      if (!defined $prev || $prev ne $name) {
        push @{ $history{$number} }, { commit => $c, name => $name };
      }
    }

    %previous_mapping = %{$current_mapping};
  }

  return (\%history, \%previous_mapping);
}

sub get_commits_affecting_path {
  my ($repo_root, $path) = @_;
  # Use %x09 for TAB so we can split on a real tab character
  my $cmd = "git -C $repo_root log --reverse --date=iso-strict --format=%H%x09%ad -- $path";
  my $out = `$cmd`;
  my $ok = ($? == 0);
  die "git log failed" unless $ok;

  my @commits;
  for my $line (split /\n/, $out) {
    $line =~ s/^\s+|\s+$//g;
    next unless length $line;
    my ($sha, $date) = split(/\t/, $line, 2);
    push @commits, { sha => $sha, date_iso => $date };
  }
  return \@commits;
}

sub read_file_at_commit {
  my ($repo_root, $sha, $path) = @_;
  my $spec = "$sha:$path";
  my $cmd = "git -C $repo_root show $spec 2>/dev/null";
  my $out = `$cmd`;
  my $ok = ($? == 0);
  return '' unless $ok; # File may not exist in early commits
  return $out;
}

sub parse_fgmodel_mapping {
  my ($text) = @_;
  my %mapping;

  my $re = qr/^\s*([A-Za-z0-9][A-Za-z0-9_-]*)\s+OBJECT\s+IDENTIFIER\s+::=\s*\{\s*fgModel\s+(\d+)\s*\}\s*$/;
  for my $raw (split /\n/, $text) {
    my ($line) = split /--/, $raw, 2;   # strip MIB inline comments
    next unless defined $line;
    next unless $line =~ /\S/;
    if ($line =~ /$re/) {
      my ($name, $num) = ($1, $2);
      $mapping{$num} = $name;
    }
  }
  return \%mapping;
}

## Backtick capture is used for simplicity and portability.


