#!/usr/bin/perl -w

use strict;
use Test;
use Business::CINS;

BEGIN { plan tests => 24 }

# Check some fixed income securities
my @values = ('P8055KAPR','1', 'Y39993AD5','6', 'G4768JAA3','4',
              'Y485632AB','5', 'G98930QAA','4', 'Y7318VAA4','0',
              'G6954PAK6','3', 'U24627AC2','8'
              );
while (@values) {
  my ($v, $expected) = splice @values, 0, 2;
  my $cn = Business::CINS->new($v.$expected, 1);
  my $c = $cn->check_digit();
  ok($c, $expected, "check_digit of $v expected $expected; got $c\n");
  ok($cn->is_valid());
  $cn->cins("$v".(9-$expected));
  ok(!$cn->is_valid());
}

__END__
