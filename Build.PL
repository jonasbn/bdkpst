# Build.PL for Business-DK-Postalcode

# $Id: Build.PL,v 1.2 2006-05-11 11:17:25 jonasbn Exp $

use Module::Build;
my $build = Module::Build->new(
	dist_author        => 'Jonas B. Nielsen, (jonasbn) <jonasbn@cpan.org>',
	module_name        => 'Business::DK::Postalcode',
	dist_version_from  => 'lib/Business/DK/Postalcode.pm',
	license            => 'artistic',
	create_makefile_pl => 'passthrough',
);
$build->create_build_script();
