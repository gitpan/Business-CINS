#!/usr/bin/perl -w

use strict;
use Test;
use Business::CINS;

BEGIN { plan tests => 11 }

my $cins = Business::CINS->new();
ok($cins->cins, undef);
ok(!$cins->is_fixed_income);
ok($cins->is_fixed_income(1));
ok($cins->is_fixed_income);
ok($cins->cins('P8055KAP00'), 'P8055KAP00');
ok($cins->domicile_code, 'P');
ok($cins->issuer_num, '8055KA');
ok($cins->issue_num, 'P0');

$cins = Business::CINS->new('P8055KAPR1', 1);
ok($cins->is_fixed_income);
ok(!$cins->is_fixed_income(0));
ok(!$cins->is_fixed_income);

__END__
