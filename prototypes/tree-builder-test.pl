#!/usr/bin/perl -w

use strict;
use Data::Dumper;
use Tree::Simple;

my $tree = Tree::Simple->new();

my @data = qw(1234 1235 2345 2346);

my $oldtree = $tree;

my $j = 0;
foreach my $number (@data) {
	$j++;
	print STDERR "\nWe have number: $number [$j]\n";
	my @digits = split(//, $number, 4);
	
	for(my $i = 0; $i < scalar(@digits); $i++) {

		print STDERR "We have digit: ".$digits[$i]."\n";
		if ($i == 0) {
			print STDERR "We are resetting to oldtree: $i\n";
			$tree = $oldtree;
		}
		
 		my $subtree = Tree::Simple->new($digits[$i]);
 		
 		my @children = $tree->getAllChildren();
 		my $child = undef;
 		foreach my $c (@children) {
 			print STDERR "\$c: ".$c->getNodeValue()."\n";
 			if ($c->getNodeValue() == $subtree->getNodeValue()) {
				$child = $c;
				last;
 			}
 		}

  		if ($child) {
 			print STDERR "We are represented at $i with $digits[$i], we go to next\n";
		 	$tree = $child;
 		} else {
			print STDERR "We are adding child ".$subtree->getNodeValue."\n";
			$tree->addChild($subtree);
		 	$tree = $subtree;
 		}
	}
}
$tree = $oldtree;

$tree->traverse(sub {
	  my ($_tree) = @_;
	  print (("->" x $_tree->getDepth()), $_tree->getNodeValue(), "\n");
});
