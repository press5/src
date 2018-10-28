#!/usr/bin/env perl
use LWP::Simple;
use XML::TreeBuilder;
my $datasrc = get("http://127.0.0.1/stat"); # change this address to your rtmp stat page.
my $tree = XML::TreeBuilder->new(); 
$tree->parse($datasrc); 
foreach my $app ($tree->find_by_tag_name('application')){
 print $app->find_by_tag_name('name')->as_text . '-';
 if ($app->find('publishing')) { print "publishing";}
 print "\n";
}
