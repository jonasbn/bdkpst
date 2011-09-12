# $Id$

use strict;
use warnings;
use Test::More qw(no_plan);

use Business::DK::Postalcode qw(validate);

my @invalids = qw();
my @valids = qw();

foreach (1 .. 9999) {
    my $number = sprintf '%04d', $_;
    if (not validate($number)) {
        push @invalids, $number;
    } else {
        push @valids, $number;
    }
}

is(scalar @invalids, (10000 -  1283));
