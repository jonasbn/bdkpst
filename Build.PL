# Build.PL for Business-DK-Postalcode

# $Id: Build.PL,v 1.3 2008-09-09 19:17:21 jonasbn Exp $

use Module::Build;
my $build = Module::Build->new(
	dist_author        => 'Jonas B. Nielsen, (jonasbn) <jonasbn@cpan.org>',
	module_name        => 'Business::DK::Postalcode',
	dist_version_from  => 'lib/Business/DK/Postalcode.pm',
	dist_abstract      => 'Module contaning danish zipcodes',
	license            => 'artistic',
	create_makefile_pl => 'passthrough',
);
$build->create_build_script();
