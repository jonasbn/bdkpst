# $Id: create_regex.t,v 1.2 2008-09-09 19:17:27 jonasbn Exp $

use strict;
use warnings;
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
ok($regex = create_regex((get_all_postalcodes(@data))));

#test 3
is($$regex, '0555');


@data = qw(
0555	Scanning		Data Scanning A/S "L�s Ind"-service	False	1	
0800	H�je Taastrup	Girostr�get 1	BG-Bank A/S	True	1	
);

#test 4
ok($regex = create_regex(get_all_postalcodes(@data)));

#test 5
#is($$regex, '(?:0)((?:5)(?:5)(?:5)|(?:8)(?:0)(?:0))');
is($$regex, '0(555|800)');

#test 6 .. 
foreach my $postalcode (@{get_all_postalcodes(@data)}) {
	ok($postalcode =~ m/$$regex/, "$postalcode tested against $$regex");
}

@data = qw(
0555	Scanning		Data Scanning A/S "L�s Ind"-service	False	1	
0800	H�je Taastrup	Girostr�get 1	BG-Bank A/S	True	1	
0877	Valby	Vigerslev All� 18	Aller Press (konkurrencer)	False	1
1665	K�benhavn V	Valdemarsgade		False	1	
1666	K�benhavn V	Matth�usgade		False	1	
);

#test 7
ok($regex = create_regex(get_all_postalcodes(@data)));

#test 8
#is($$regex, '((?:0)((?:5)(?:5)(?:5)|(?:8)((?:0)(?:0)|(?:7)(?:7)))|(?:1)(?:6)(?:6)((?:5)|(?:6)))');

is($$regex, '(0(555|8(00|77))|166(5|6))');

@data = qw(
0555	Scanning		Data Scanning A/S "L�s Ind"-service	False	1	
0877	Valby	Vigerslev All� 18	Aller Press (konkurrencer)	False	1
1665	K�benhavn V	Valdemarsgade		False	1	
4100	Ringsted			True	1	
);

#test 7
ok($regex = create_regex(get_all_postalcodes(@data)));

#test 8
#is($$regex, '((?:0)((?:5)(?:5)(?:5)|(?:8)((?:0)(?:0)|(?:7)(?:7)))|(?:1)(?:6)(?:6)((?:5)|(?:6)))');

is($$regex, '(0(555|877)|1665|4100)');

#test 9 .. 
foreach my $postalcode (@{get_all_postalcodes(@data)}) {
	ok($postalcode =~ m/$$regex/, "$postalcode tested against $$regex");
}

@data = qw(
1300	K�benhavn K	Borgergade		False	1	
1301	K�benhavn K	Landgreven		False	1	
1302	K�benhavn K	Dronningens Tv�rgade		False	1	
1303	K�benhavn K	Hindegade		False	1	
1304	K�benhavn K	Adelgade		False	1	
1306	K�benhavn K	Kronprinsessegade		False	1	
1307	K�benhavn K	S�lvgade		False	1	
1307	K�benhavn K	Georg Brandes Plads		False	1	
1308	K�benhavn K	Klerkegade		False	1	
1309	K�benhavn K	Rosengade		False	1	
1310	K�benhavn K	Fredericiagade		False	1	
);

#test 7
ok($regex = create_regex(get_all_postalcodes(@data)));

#test 8
#is($$regex, '((?:0)((?:5)(?:5)(?:5)|(?:8)((?:0)(?:0)|(?:7)(?:7)))|(?:1)(?:6)(?:6)((?:5)|(?:6)))');

is($$regex, '13(0(0|1|2|3|4|6|7|8|9)|10)');

#test 9 .. 
foreach my $postalcode (@{get_all_postalcodes(@data)}) {
	ok($postalcode =~ m/$$regex/, "$postalcode tested against $$regex");
}

#test 10
ok($regex = create_regex(get_all_postalcodes()));

#test 11
foreach my $postalcode (@{get_all_postalcodes()}) {
	ok($postalcode =~ m/$$regex/, "$postalcode tested");
}