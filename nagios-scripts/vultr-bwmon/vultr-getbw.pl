#!/usr/bin/env perl 
# warning: this code breaks strict. i might fix why at some point, but not now.
use JSON::Parse qw(parse_json); 
my %opt = (
  debug => 1,
    key => "", # your API key goes here
   curl => "/usr/bin/curl", # adust for curl
);
if ($opt{key} eq '') { print "add your api key in the file\n"; exit 1; }
# i was going to do this the right way but... eh. kake26 would be proud of my lazy.
my $apidata = `$opt{curl} -sG "https://api.vultr.com/v1/server/list?api_key=$opt{key}"`;
# if you get a json parse error make sure you whitelisted the IP to the API 
# TODO: add something that will catch that and tell the user
my $data = parse_json($apidata);
foreach my $node (%$data) { 
my $label; my $cbw; my $mbw; 
    $label = %$node{label};
  $cbw = %$node{current_bandwidth_gb};
  $mbw = %$node{allowed_bandwidth_gb};
  next unless $label; # vultr's json output is kinda meh, 
  # server label, current bandwidth, allowed max bandwidth 
  print "$label $cbw $mbw\n";
} 

