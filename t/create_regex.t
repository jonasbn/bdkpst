# $Id: create_regex.t,v 1.2 2008-09-09 19:17:27 jonasbn Exp $

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

__END__

#test 9 .. 
foreach my $postalcode (@{get_all_postalcodes(@data)}) {
	ok($postalcode =~ m/$$regex/, "$postalcode tested against $$regex");
}

#test 10
ok($regex = create_regex(get_all_postalcodes()));

print STDERR $$regex;

#test 11
foreach my $postalcode (@{get_all_postalcodes()}) {
	ok($postalcode =~ m/$$regex/, "$postalcode tested");
}

print STDERR $$regex;