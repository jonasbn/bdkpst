# $Id$

use strict;
use warnings;
use Test::More tests => 10;

use Data::FormValidator;

use_ok('Data::FormValidator::Constraints::Business::DK::Postalcode', qw(valid_postalcode));

my $dfv_profile = {
    required => [qw(postalcode)],
    constraint_methods => {
        postalcode => valid_postalcode(),
    }
};

my $input_hash;
my $result;

$input_hash = {
    postalcode  => '0000',
};

$result = Data::FormValidator->check($input_hash, $dfv_profile);

ok(! $result->success);

ok($result->has_invalid);
ok(! $result->has_unknown);
ok(! $result->has_missing);

$input_hash = {
    postalcode => 2300,
};

ok($result = Data::FormValidator->check($input_hash, $dfv_profile));

ok(! $result->has_invalid);
ok(! $result->has_unknown);
ok(! $result->has_missing);

$dfv_profile = {
    required => [qw(postalcode)],
    constraint_methods => {
        postalcode => valid_postalcode(),
    },
    untaint_all_constraints => 1,
};

ok($result = Data::FormValidator->check($input_hash, $dfv_profile));
