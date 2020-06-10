#!/usr/bin/perl

package CustomUserAgent; 
   
use Time::HiRes qw(usleep gettimeofday);
   
use parent 'LWP::UserAgent';

my $delay_micro = $main::delay * 1000;
my $last_ts = getTimeInMillies();

sub get {
 my ( $self, $uri ) = @_;

 my $current_ts = getTimeInMillies();
 my $duration = $current_ts - $last_ts;

 my $sleep = $delay_micro - $duration;

 if ($sleep > 0) {
  usleep($sleep);
 }

 $last_ts = getTimeInMillies();
 
 my $ref = $self->SUPER::get($uri);

 return $ref;
}

sub getTimeInMillies {
my $seconds;
my $microseconds;
 ($seconds, $microseconds) = gettimeofday;
 my $time = $seconds * 1000000 + $microseconds;
 return $time;
}

1;
