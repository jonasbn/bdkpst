# $Id: get_all_postalcodes.t,v 1.1 2006-04-23 10:21:24 jonasbn Exp $

use strict;
use Test::More tests => 3;

#test 1
BEGIN { use_ok('Business::DK::Postalcode', qw(get_all_postalcodes)); }

#test 2
ok(my $postalcodes = get_all_postalcodes());

#test 3
is(scalar(@{$postalcodes}), 1283);
