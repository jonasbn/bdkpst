# $Id: get_all_postalcodes.t,v 1.1 2006-04-23 10:21:24 jonasbn Exp $

use strict;
use warnings;
use Data::Dumper;
use Test::More tests => 4;

#test 1
BEGIN { use_ok('Business::DK::Postalcode', qw(get_all_postalcodes)); }

my $postalcodes;

#test 2
ok($postalcodes = get_all_postalcodes());

#test 3
is(scalar(@{$postalcodes}), 1283);

print STDERR Dumper $postalcodes;

ok($postalcodes = get_all_postalcodes());

print STDERR Dumper $postalcodes;
