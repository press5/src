#!/usr/bin/env perl
use strict; 
use warnings;
use diagnostics; 

my %opt = (
     debug => 0,
    bwfile => "",
  hostname => "",
  warn_thr => 80,
  crit_thr => 90,
);

$opt{bwfile}   = $ARGV[0];
$opt{hostname} = $ARGV[1];
if ($ARGV[2]) {$opt{warn_thr} = $ARGV[2];};
if ($ARGV[3]) {$opt{crit_thr} = $ARGV[3];};
chomp($opt{bwfile}); 
chomp($opt{hostname});
# TODO: some error checking 
open(DAT, "<", "$opt{bwfile}") or exit 3; # ret UNKNOWN if bwfile is bad
my @dat;
while (<DAT>) {push (@dat, $_);}
close DAT; # and shut 
my @spec = grep /\b$opt{hostname}\b/x, @dat;
print "$spec[0]" if $opt{debug};
my @box = split / /, $spec[0];
chomp(@box); # heh. 
print "hostname $box[0] used $box[1] quota $box[2]\n" if $opt{debug};
my $perc = $box[1]/$box[2]*100; # get a percentage! 
$perc = substr($perc,0,5); # trunc the result 
#TODO: this ^ should probably be some kind of rounding func instead
my $msg = "$perc% used: $box[1] of $box[2] GB bandwidth\n"; 
if ($perc lt $opt{warn_thr}) {
  print "OK: $msg"; exit 0;};  # returns OK
if ($perc gt $opt{warn_thr} && $perc lt $opt{crit_thr}) {
  print "WARNING: $msg"; exit 1;};  # returns WARNING
if ($perc gt $opt{crit_thr}) {
  print "CRITICAL: $msg"; exit 2;};  # returns CRITICAL
