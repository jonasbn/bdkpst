#!/usr/bin/env perl

use strict;
use warnings;
use Spreadsheet::ParseExcel;
use Encode qw(from_to decode encode);
use FindBin;
use lib "$FindBin::Bin/../lib";
use Getopt::Long;
use List::MoreUtils qw(any);
use Module::Load; #load

use utf8;

my $file;
my $verbose;
my $country = 'DK';

my %countries = (
    DK => 1,
    FO => 2,
    GL => 3,
);

GetOptions ('file=s'   => \$file,      # string
            'verbose'  => \$verbose,   # flag
            'country=s'  => \$country)
or die("Error in command line arguments\n");

#translating to internal representation
my $country_internal = $countries{$country};

my $parser = Spreadsheet::ParseExcel->new();

my $workbook = $parser->parse($file);

if ( not defined $workbook ) {
    die $parser->error(), ".\n";
}

my $module = 'Business::'.$country.'::Postalcode';
load $module, 'get_all_data';

my $postalcodes = get_all_data();

for my $worksheet ( $workbook->worksheets() ) {

    my ( $row_min, $row_max ) = $worksheet->row_range();
    my ( $col_min, $col_max ) = $worksheet->col_range();

    ROW: for my $row ( $row_min .. $row_max ) {
        my $record;

        my $string = '';
        my $seperator = '';
        for my $col ( $col_min .. $col_max ) {

            my $cell = $worksheet->get_cell( $row, $col );

            if ($col == $col_max) {
                $seperator = "\n";
            } else {
                $seperator = "\t";
            }

            if (not $cell) {
                $string .= $seperator;
                next;
            }


            if ($col == 5) {

                my $col_country = $cell->value();

                if ($col_country ne $country_internal) {
                    if ($verbose) {
                        print STDERR "Skipping row ($row), another country\n";
                    }
                    next ROW;
                }
            }

            $string .= ($cell->value || '' ). $seperator;
        }
        if (any { $string eq decode('UTF-8', $_) } @{$postalcodes}) {
            if ($verbose) {
                print "Known record: ", encode('UTF-8', $string);
            }
        } else {
            print "New record: ", encode('UTF-8', $string);
        }
    }


}

exit 0;
