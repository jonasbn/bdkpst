# $Id: _build_tree.t,v 1.1 2006-04-23 10:21:24 jonasbn Exp $

use strict;
use Test::More qw(no_plan);
use Tree::Simple;

my $VERBOSE = 0;

BEGIN { use_ok('Business::DK::Postalcode', qw(get_all_postalcodes)); }

my $tree = Tree::Simple->new("0", Tree::Simple->ROOT);

ok(Business::DK::Postalcode::_build_tree($tree, 4321));

is($tree->size, 5);

if ($VERBOSE) {
	$tree->traverse(sub {
		my ($_tree) = @_;
		print (("\t" x $_tree->getDepth()), $_tree->getNodeValue(), "\n");
	});
}

$tree = Tree::Simple->new("0", Tree::Simple->ROOT);

my @data = qw(0800 0500 0911 0577);
foreach my $postalcode (@data) {
	ok(Business::DK::Postalcode::_build_tree($tree, $postalcode));
}

is($tree->size, 14);

if ($VERBOSE) {
	$tree->traverse(sub {
		my ($_tree) = @_;
		print (("\t" x $_tree->getDepth()), $_tree->getNodeValue(), "\n");
	});
}

$tree = Tree::Simple->new("0", Tree::Simple->ROOT);

my $postalcodes = Business::DK::Postalcode::get_all_postalcodes();

foreach my $postalcode (@{$postalcodes}) {
	ok(Business::DK::Postalcode::_build_tree($tree, $postalcode));
}

if (1) {
	$tree->traverse(sub {
		my ($_tree) = @_;
		print (("\t" x $_tree->getDepth()), $_tree->getNodeValue(), "\n");
	});
}