#!/usr/bin/perl -w

use strict;
use Test;
use Business::CINS;

BEGIN { plan tests => 54 }

# Bad length
foreach ('R92940*11', 'S00077202', 'L20427#10', 'U38080R10') {
  my $cn = Business::CINS->new($_);
  ok($cn->is_valid, '', "  Expected an error, but CINS $_ seems to be valid.");
  ok($Business::CINS::ERROR, qr/^CINS .* 10 characters/,
     "  Got an unexpected error: $Business::CINS::ERROR.");
}

# Bad Domicile Code in position 1
foreach ('98055KAP00', 'Z39993AD56', 'O4768JAA34') {
  my $cn = Business::CINS->new($_);
  ok($cn->is_valid, '', "  Expected an error, but CINS $_ seems to be valid.");
  ok($Business::CINS::ERROR, qr/^First character/,
     "  Got an unexpected error: $Business::CINS::ERROR.");
}

# Non-numeric in position 2-4
foreach ('YA85632AB5', 'G9B930QAA4', 'Y7E18VAA40') {
  my $cn = Business::CINS->new($_);
  ok($cn->is_valid, '', "  Expected an error, but CINS $_ seems to be valid.");
  ok($Business::CINS::ERROR, qr/^Characters 2-4/,
     "  Got an unexpected error: $Business::CINS::ERROR.");
}

# Bad char in position 4-8
foreach ('Y485g32AB5', 'G989l0QAA4', 'Y731&VAA40') {
  my $cn = Business::CINS->new($_);
  ok($cn->is_valid, '', "  Expected an error, but CINS $_ seems to be valid.");
  ok($Business::CINS::ERROR, qr/^Characters 5-9/,
     "  Got an unexpected error: $Business::CINS::ERROR.");
}

# Non-numeric check digit
foreach ('Y485632ABS', 'G98930QAAA', 'Y7318VAA4O', 'G6954PAK6E', 'U24627AC2B'){
  my $cn = Business::CINS->new($_);
  ok($cn->is_valid, '', "  Expected an error, but CINS $_ seems to be valid.");
  ok($Business::CINS::ERROR, qr/^Character 10/,
     "  Got an unexpected error: $Business::CINS::ERROR.");
}

# These should fail because of the I1O0 business
foreach ('P8055KAPI0', 'Y485632A15', 'G98930QAO4', 'Y7318VAA00') {
  my $cn = Business::CINS->new($_, 1);
  ok($cn->is_valid, '', "  Expected an error, but CINS $_ seems to be valid.");
  ok($Business::CINS::ERROR, qr/^Fixed income CINS cannot contain/,
     "  Did not get the expected error. Got $Business::CINS::ERROR\n");
}

# Bad check digit
foreach ('P8055KAP05', 'G4768JAA37', 'Y485632AB6', 'Y7318VAA45', 'G6954PAK69'){
  my $cn = Business::CINS->new($_);
  ok($cn->is_valid, '', "  Expected an error, but CINS $_ seems to be valid.");
  ok($Business::CINS::ERROR, qr/^Check digit not correct/,
     "  Got an unexpected error: $Business::CINS::ERROR.");
}

__END__
