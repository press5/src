#!/usr/bin/perl

use strict;
use warnings;
use IO::Handle;

my $merge = $ARGV[0];
my $file  = $ARGV[1];

if (   ( not $merge )
    or ( $merge =~ /\D/ )
    or ( not $file ) )
{
    print "Usage: $0 <count> <file>\n";
    exit(1);
}

if ( not -e $file ) {
    print "File: [$file] not found.\n";
    exit(1);
}

my $line_number = 0;
my $this_line   = "";
my $shell_call  = "$file";
open( my $file_handle, "<", "$shell_call" )
  or die "Failed to read: [$file], error: $!\n";
while (<$file_handle>) {
    chomp;
    my $line = $_;
    if ( $line_number == $merge ) {
        $this_line =~ s/ $//g;
        print "$this_line\n";
        $this_line   = "";
        $line_number = 0;
    }
    $this_line .= "$line ";
    $line_number++;
}
close $file_handle;

exit(0);

