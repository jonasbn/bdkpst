#!/usr/local/bin/perl

# $Id$

use strict;
use warnings;
use Test::More tests => 12;
use Test::Taint;
use Data::FormValidator;

use lib qw(lib);

#taint_checking_ok('Is taint checking on');

use_ok( 'Data::FormValidator::Constraints::Business::DK::Postalcode',
    qw(valid_postalcode) );

my $dfv_profile = {
    required           => [qw(postalcode)],
    constraint_methods => { postalcode => valid_postalcode(), }
};

my $input_hash;
my $result;

$input_hash = { postalcode => 1234, };

#Tainting data
taint_deeply($input_hash);
tainted_ok_deeply( $input_hash, 'Checking that our data are tainted' );

$result = Data::FormValidator->check( $input_hash, $dfv_profile );

ok( !$result->success, 'The data was not conforming to the profile' );

ok( $result->has_invalid,  'Checking that we have invalids' );
ok( !$result->has_unknown, 'Checking that we have no unknowns' );
ok( !$result->has_missing, 'Checking that we have no missings' );

$input_hash = { postalcode => 2300, };

ok( $result = Data::FormValidator->check( $input_hash, $dfv_profile ),
    'Calling check' );

ok( !$result->has_invalid, 'Checking that we have no invalids' );
ok( !$result->has_unknown, 'Checking that we have no unknowns' );
ok( !$result->has_missing, 'Checking that we have no missings' );

$dfv_profile = {
    required                  => [qw(postalcode)],
    constraint_methods        => { postalcode => valid_postalcode(), },
    untaint_constraint_fields => 1,
};

ok( $result = Data::FormValidator->check( $input_hash, $dfv_profile ),
    'Calling check' );

untainted_ok_deeply( $input_hash, 'Checking that our data are tainted' );
