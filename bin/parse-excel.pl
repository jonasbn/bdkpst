#!/usr/bin/env perl

use strict;
use warnings;
use Spreadsheet::ParseExcel;
use Encode qw(from_to decode encode);
use FindBin;
use lib "$FindBin::Bin/../lib";
use Business::DK::Postalcode qw(get_all_data);
use Getopt::Long;
use List::MoreUtils qw(any);

use utf8;

my $file;
my $verbose;
my $country = 1;

GetOptions ('file=s'   => \$file,      # string
            'verbose'  => \$verbose,   # flag
            'country'  => \$country)
or die("Error in command line arguments\n");

my $parser = Spreadsheet::ParseExcel->new();

my $workbook = $parser->parse($file);

if ( not defined $workbook ) {
    die $parser->error(), ".\n";
}

my $postalcodes = get_all_data;

foreach my $p (@{$postalcodes}) {
    $p =~ s/\t/\t/g;
}

for my $worksheet ( $workbook->worksheets() ) {

    my ( $row_min, $row_max ) = $worksheet->row_range();
    my ( $col_min, $col_max ) = $worksheet->col_range();

    ROW: for my $row ( $row_min .. $row_max ) {
        my $record;

        my $string = '';
        my $seperator = '';
        for my $col ( $col_min .. $col_max ) {

            my $cell = $worksheet->get_cell( $row, $col );
            #print STDERR "Retrieving cell: $row, $col\n";

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

                if ($col_country ne $country) {
                    if ($verbose) {
                        print STDERR "Skipping row ($row)\n";
                    }
                    next ROW;
                }
            }

            $string .= ($cell->value || '' ). $seperator;
        }
        if (any { $string eq decode('UTF-8', $_) } @{$postalcodes}) {
            if ($verbose) {
                print "we know record: ", encode('UTF-8', $string);
            }
        } else {
            print "new record: ", encode('UTF-8', $string);
        }
    }


}

exit 0;
