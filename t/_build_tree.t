# $Id: _build_tree.t,v 1.2 2006-05-11 11:24:27 jonasbn Exp $

use strict;
use Test::More qw(no_plan);
use Tree::Simple;

my $VERBOSE = 0;
my $tree;

#test 1
BEGIN { use_ok('Business::DK::Postalcode', qw(get_all_postalcodes)); }

$tree = Tree::Simple->new();

#test 2
ok(Business::DK::Postalcode::_build_tree($tree, 4321));

#test 3
is($tree->size, 5);

if ($VERBOSE) {
	$tree->traverse(sub {
		my ($_tree) = @_;
		print (("\t" x $_tree->getDepth()), $_tree->getNodeValue(), "\n");
	});
}

$tree = Tree::Simple->new();

#test 4-7
my @data = qw(0800 0500 0911 0577);
foreach my $postalcode (@data) {
	ok(Business::DK::Postalcode::_build_tree($tree, $postalcode));
}

#test 8
is($tree->size, 13);

if ($VERBOSE) {
	$tree->traverse(sub {
		my ($_tree) = @_;
		print (("\t" x $_tree->getDepth()), $_tree->getNodeValue(), "\n");
	});
}

$tree = Tree::Simple->new();

my $postalcodes = Business::DK::Postalcode::get_all_postalcodes();

#test 9-12
foreach my $postalcode (@{$postalcodes}) {
	ok(Business::DK::Postalcode::_build_tree($tree, $postalcode));
}
