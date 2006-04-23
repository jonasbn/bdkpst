# $Id: create_regex.t,v 1.1 2006-04-23 10:21:24 jonasbn Exp $

use strict;
use Data::Dumper;
use Test::More qw(no_plan);

#test 1
BEGIN { use_ok('Business::DK::Postalcode', qw(create_regex get_all_postalcodes)); }

my @data;
my $regex;

@data = qw(
0555	Scanning		Data Scanning A/S "L�s Ind"-service	False	1	
);

#test 2
ok($regex = create_regex(get_all_postalcodes(@data)));

#test 3
is($$regex, '((?0)(?5)(?5)(?5))');


@data = qw(
0555	Scanning		Data Scanning A/S "L�s Ind"-service	False	1	
0800	H�je Taastrup	Girostr�get 1	BG-Bank A/S	True	1	
);

#test 4
ok($regex = create_regex(get_all_postalcodes(@data)));

#test 5
is($$regex, '((?0)((?8)(?0)(?0)|(?5)(?5)(?5)))');

@data = qw(
0555	Scanning		Data Scanning A/S "L�s Ind"-service	False	1	
0800	H�je Taastrup	Girostr�get 1	BG-Bank A/S	True	1	
0877	Valby	Vigerslev All� 18	Aller Press (konkurrencer)	False	1
1665	K�benhavn V	Valdemarsgade		False	1	
1666	K�benhavn V	Matth�usgade		False	1	
);

#test 6
ok($regex = create_regex(get_all_postalcodes(@data)));

#test 7
is($$regex, '(0(?:8((?:0(?:0))|(?:7(?:7))))|(?:5(?:5(?:5))))');

#print STDERR "\nfor postalcodes: ".Dumper(get_all_postalcodes(@data))."\n";

#test 8 .. 
foreach my $postalcode (@{get_all_postalcodes(@data)}) {
	ok($postalcode =~ m/$regex/cg, "$postalcode tested");
}