#!/usr/bin/perl -w

use strict;
use Test;
use Business::CINS;

BEGIN { plan tests => 8 }

# Check some really bad CINSes
my @values = ('A392690!T','3', 'B035231A$','2',
              'C157125A&','3', 'D^19424AA','7');
while (@values) {
  my ($v, $expected) = splice @values, 0, 2;
  my $cn = Business::CINS->new($v.$expected, 1);
  ok(!defined($cn->check_digit()));
  ok($Business::CINS::ERROR, qr/^Invalid char/,
     "  Did not get the expected error. Got $Business::CINS::ERROR\n");
}

__END__
