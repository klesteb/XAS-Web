package XAS::Web::Constraints::ValidEmail;

our $VERSION = '0.01';

use Email::Valid;

use XAS::Class
  version   => $VERSION,
  base      => 'Badger::Exporter',
  constants => 'TRUE FALSE',
  exports => {
      all => 'valid_email',
      any => 'valid_email'
  }
;

# -----------------------------------------------------------------
# Public Methods
# -----------------------------------------------------------------

sub valid_email {
    
    return sub {
        my $dfv = shift;
                    
        $dfv->name_this('email');
            
        my $val = $dfv->get_current_constraint_value();
        my $rc = Email::Valid->address(
            '-address' => $val,
            '-mxcheck' => 1
        );
                    
        return defined $rc;
                    
    }
    
}    

1;
=head1 NAME

XAS::Web::Profiles::Constraints::ValidEmail - A class for creating a Data::FormValidator constraint.

=head1 SYNOPSIS

use XAS::Web::Profiles::Constraints::ValidEmail ':all';

=head1 DESCRIPTION

This module provides constraints the are usable with 
L<Data::FormValidator|https://metacpan.org/pod/Data::FormValidator>
parameter validation.

=head1 METHODS

=head2 valid_email

This constriant checks to see if an email address is conformant with
RFC 822 and wither a MX record exists for the domain.

=head1 SEE ALSO

=over 4

=item L<XAS::Web::Profiles|XAS::Web::Profiles>

=item L<XAS::Web|XAS::Web>

=item L<XAS|XAS>

=back

=head1 AUTHOR

Kevin L. Esteb, E<lt>kevin@kesteb.usE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2012-2023 Kevin L. Esteb

This is free software; you can redistribute it and/or modify it under
the terms of the Artistic License 2.0. For details, see the full text
of the license at http://www.perlfoundation.org/artistic_license_2_0.

=cut

