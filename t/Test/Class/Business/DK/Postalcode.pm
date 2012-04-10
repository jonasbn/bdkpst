package Test::Class::Business::DK::Postalcode;

# $Id$

use strict;
use warnings;
use base qw(Test::Class);
use Test::More;
use Tree::Simple;
use Test::Exception;
use Env qw($TEST_VERBOSE);

sub startup : Test(startup => 1) {
    my $self = shift;

    use_ok( 'Business::DK::Postalcode', qw(validate_postalcode get_all_postalcodes create_regex) );
};

sub test_validate : Test(5) {
    my $self = shift;

    my @invalids = qw();
    my @valids = qw();
    
    foreach (1 .. 9999) {
        my $number = sprintf '%04d', $_;
        if (not validate_postalcode($number)) {
            push @invalids, $number;
        } else {
            push @valids, $number;
        }
    }
    
    is(scalar @invalids, 8825);
    is(scalar @valids, 1174);
}

sub test_create_regex : Test(2333) {
    my $postalcodes = get_all_postalcodes();
    my $regex = create_regex($postalcodes);

    foreach my $postalcode (@{$postalcodes}) {
        ok($postalcode =~ m/$$regex/cg, "$postalcode tested");
    }   
};

sub test_build_tree : Test(1262) {
        
    my $tree = Tree::Simple->new();
    
    ok(Business::DK::Postalcode::_build_tree($tree, 4321));
    
    is($tree->size, 5);
    
    if ($TEST_VERBOSE) {
        $tree->traverse(sub {
            my ($_tree) = @_;
            print (("\t" x $_tree->getDepth()), $_tree->getNodeValue(), "\n");
        });
    }
    
    $tree = Tree::Simple->new();
    
    my @data = qw(0800 0500 0911 0577);
    foreach my $postalcode (@data) {
        ok(Business::DK::Postalcode::_build_tree($tree, $postalcode));
    }
    
    is($tree->size, 13);
    
    if ($TEST_VERBOSE) {
        $tree->traverse(sub {
            my ($_tree) = @_;
            print (("\t" x $_tree->getDepth()), $_tree->getNodeValue(), "\n");
        });
    }
    
    $tree = Tree::Simple->new();
    
    my $postalcodes = Business::DK::Postalcode::get_all_postalcodes();
    
    foreach my $postalcode (@{$postalcodes}) {
        ok(Business::DK::Postalcode::_build_tree($tree, $postalcode));
    }
    
    $tree = Tree::Simple->new();
    dies_ok { Business::DK::Postalcode::_build_tree($tree, 'BADDATA'); } 'test with bad data';
};

1;
