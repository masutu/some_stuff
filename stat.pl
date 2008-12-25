#!/usr/bin/perl

#use strict;
use warnings;
use lib '/home/mos/libperl/share/perl/5.10.0';
use Sys::Statistics::Linux;
use Net::OpenSoundControl::Client;

my $lxs = Sys::Statistics::Linux->new( cpustats => 1 );

my $client = Net::OpenSoundControl::Client->new(
  Host => "localhost",
  Port => 6450)
  or die "Could not start OSC client: $@\n";

while (1) {
  my $stat = $lxs->get;
  my $cpu_tot  = $stat->cpustats(cpu, total);

  $client->send(['/tot', 'f', $cpu_tot]);
  print "$cpu_tot\n";
  sleep(1);
}

