package Data::FormValidator::Constraints::Business::DK::Postalcode;

# $Id$

use strict;
use warnings;
use vars qw(@ISA $VERSION @EXPORT_OK);
use Business::DK::Postalcode qw(validate);
use Scalar::Util qw(blessed);
use Carp qw(croak);

use base 'Exporter';

@EXPORT_OK = qw(valid_postalcode match_postalcode);

use constant VALID   => 1;
use constant INVALID => undef;

$VERSION = '0.01';

sub valid_postalcode {
    return sub {
        my $dfv = shift;

        if ( !blessed $dfv || !$dfv->isa('Data::FormValidator::Results') ) {
            croak('Must be called using \'constraint_methods\'!');
        }

        my $postalcode = $dfv->get_current_constraint_value;

        if ( ref $dfv ) {
            $dfv->name_this('valid_postalcode');
        }

        if ( validate($postalcode) ) {
            return VALID;
        } else {
            return INVALID;
        }
        }
}

sub match_postalcode {
    my $dfv = shift;

    # if $dfv is a ref then we are called as 'constraint_method'
    # else as 'constraint'

    my $postalcode = ref $dfv ? $dfv->get_current_constraint_value : $dfv;

    my ($untainted_postalcode) = $postalcode =~ m/\A(\d{4})\Z/msx;

    return $dfv->untainted_constraint_value($untainted_postalcode);
}

1;

__END__

=pod

=head1 NAME

Data::FormValidator::Constraints::Business::DK::Postalcode - constraint for Danish Postalcodes

=head1 VERSION

The documentation describes version 0.01 of Data::FormValidator::Constraints::Business::DK::Postalcode

=head1 SYNOPSIS

  use Data::FormValidator;
  use Data::FormValidator::Constraints::Business::DK::Postalcode qw(valid_postalcode);

    my $dfv_profile = {
        required => [qw(postalcode)],
        constraint_methods => {
            postalcode => valid_postalcode(),
        }
    };

    my $dfv_profile = {
        required => [qw(postalcode)],
        constraint_methods => {
            postalcode => valid_postalcode(),
        },
        untaint_all_constraints => 1,
    };


=head1 DESCRIPTION

This module exposes a set of subroutines which are compatible with
L<Data::FormValidator>. The module implements contraints as specified in
L<Data::FormValidator::Constraints>.

For a more through description of Danish postal codes please see: L<Business::DK::Postalcode>.

=head1 SUBROUTINES AND METHODS

=head2 valid_postalcode

Checks whether a Postalcode is valid (see: SYNOPSIS) and L<Business::DK::Postalcode>

=head2 match_postalcode

Untaints a given Postalcode (see: SYNOPSIS and BUGS AND LIMITATIONS)

=head1 EXPORTS

Data::FormValidator::Constraints::Business::DK::Postalcode exports on request:

=over

=item * L</valid_postalcode>

=item * L</match_postalcode>

=back

=head1 DIAGNOSTICS

=over

=item * Please refer to L<Data::FormValidator> for documentation on this

=back

=head1 CONFIGURATION AND ENVIRONMENT

The module requires no special configuration or environment to run.

=head1 DEPENDENCIES

=over

=item * L<Data::FormValidator>

=item * L<Business::DK::Postalcode>

=back

=head1 INCOMPATIBILITIES

The module has no known incompatibilities.

=head1 BUGS AND LIMITATIONS

The tests seem to reflect that untainting takes place, but the L</match_valid_postalcode> is not called at all, so
how this untaiting is expected integrated into L<Data::FormValidator> is still not settled (SEE: TODO)

=head1 TEST AND QUALITY

Coverage of the test suite is at 57.6%

=head1 TODO

=over

=item * Get the untaint functionality tested thoroughly, that would bring the coverage to 100%, the L</match_valid_postalcode> does not seem to be run.

=item * Comply with Data::FormValidator, especially for untainting

=back

=head1 SEE ALSO

=over

=item * L<Data::FormValidator>

=item * L<Data::FormValidator::Constraints>

=item * L<Data::FormValidator::Result>

=item * L<Business::DK::Postalcode>

=back

=head1 BUG REPORTING

Please report issues via CPAN RT:

  http://rt.cpan.org/NoAuth/Bugs.html?Dist=Business-DK-Postalcode

or by sending mail to

  bug-Business-DK-Postalcode@rt.cpan.org
  
=head1 AUTHOR

Jonas B. Nielsen, (jonasbn) - C<< <jonasbn@cpan.org> >>

=head1 COPYRIGHT

Business-DK-Postalcode and related is (C) by Jonas B. Nielsen, (jonasbn) 2006-2011

=head1 LICENSE

Business-DK-Postalcode and related is released under the artistic license

The distribution is licensed under the Artistic License, as specified
by the Artistic file in the standard perl distribution
(http://www.perl.com/language/misc/Artistic.html).

=cut
