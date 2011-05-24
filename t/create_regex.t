# $Id: create_regex.t,v 1.2 2008-09-09 19:17:27 jonasbn Exp $

use strict;
use Data::Dumper;
use Test::More qw(no_plan);

#test 1
BEGIN { use_ok('Business::DK::Postalcode', qw(create_regex get_all_postalcodes)); }

my @data;
my $regex;

#@data = qw(
#0555	Scanning		Data Scanning A/S "Læs Ind"-service	False	1	
#);

#test 2
#ok($regex = create_regex(get_all_postalcodes(@data)));

#test 3
#is($$regex, '(?:0)(?:5)(?:5)(?:5)');


@data = qw(
0555	Scanning		Data Scanning A/S "Læs Ind"-service	False	1	
0800	Høje Taastrup	Girostrøget 1	BG-Bank A/S	True	1	
);

#test 4
ok($regex = create_regex(get_all_postalcodes(@data)));

#test 5
#is($$regex, '(?:0)((?:5)(?:5)(?:5)|(?:8)(?:0)(?:0))');
is($$regex, '0(555|800)');

@data = qw(
0555	Scanning		Data Scanning A/S "Læs Ind"-service	False	1	
0800	Høje Taastrup	Girostrøget 1	BG-Bank A/S	True	1	
0877	Valby	Vigerslev Allé 18	Aller Press (konkurrencer)	False	1
1665	København V	Valdemarsgade		False	1	
1666	København V	Matthæusgade		False	1	
);

#test 6
ok($regex = create_regex(get_all_postalcodes(@data)));

#test 7
#is($$regex, '((?:0)((?:5)(?:5)(?:5)|(?:8)((?:0)(?:0)|(?:7)(?:7)))|(?:1)(?:6)(?:6)((?:5)|(?:6)))');

is($$regex, '(0(555|8(00|77))|166(5|6))');

#print STDERR "\nfor postalcodes: ".Dumper(get_all_postalcodes(@data))."\n";

#test 8 .. 
foreach my $postalcode (@{get_all_postalcodes(@data)}) {
	ok($postalcode =~ m/$$regex/, "$postalcode tested against $$regex");
}