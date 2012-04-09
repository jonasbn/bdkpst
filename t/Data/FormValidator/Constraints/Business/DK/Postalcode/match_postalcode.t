#!/usr/local/bin/perl -T

# $Id$

use strict;
use warnings;
use Test::More tests => 16;
use Test::Taint;
use Data::FormValidator;

use lib qw(lib);

taint_checking_ok('Is taint checking on?');

use_ok( 'Data::FormValidator::Constraints::Business::DK::Postalcode',
    qw(postalcode danish_postalcode postalcode_denmark valid_postalcode) );

my $dfv_profile = {
    required           => [qw(postalcode)],
    constraint_methods => { postalcode => postalcode(), }
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
taint_deeply($input_hash);
tainted_ok_deeply( $input_hash, 'Checking that our data are tainted' );

ok( $result = Data::FormValidator->check( $input_hash, $dfv_profile ),
    'Calling check' );

ok( !$result->has_invalid, 'Checking that we have no invalids' );
ok( !$result->has_unknown, 'Checking that we have no unknowns' );
ok( !$result->has_missing, 'Checking that we have no missings' );

tainted_ok_deeply( $input_hash, 'Checking that our data are tainted' );

# We now investigate untainting 

$dfv_profile = {
    required                  => [qw(postalcode)],
    constraint_methods        => { postalcode => postalcode(), },
    #untaint_constraint_fields => [qw(postalcode)],
    untaint_all_constraints   => 1,
};

my $input_hash2 = { postalcode => 2300, };

taint_deeply($input_hash2);
tainted_ok_deeply( $input_hash2, 'Checking that our data are tainted' );

ok( $result = Data::FormValidator->check( $input_hash2, $dfv_profile ),
    'Calling check' );

untainted_ok( $result->valid('postalcode'), 'Checking that our data are untainted' );
