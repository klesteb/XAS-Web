package XAS::Web::Constraints::ValidUrl;

our $VERSION = '0.01';

use Badger::URL 'URL';

use XAS::Class
  version   => $VERSION,
  base      => 'Badger::Exporter',
  constants => 'TRUE FALSE',
  exports => {
      all => "valid_url',
      any => 'valid_url'
  }
;

# -----------------------------------------------------------------
# Public Methods
# -----------------------------------------------------------------

sub valid_url {
    
    return sub {
        my $dfv = shift;
                    
        $dfv->name_this('url');
                    
        my $val = $dfv->get_current_constraint_value();
        my $url = URL($val);
                    
        return ($url->server ne '');
                
    }
        
}

1;
=head1 NAME

XAS::Web::Profiles::Constraints::ValidUrl - A class for creating a Data::FormValidator constraint.

=head1 SYNOPSIS

use XAS::Web::Profiles::Constraints::ValidUrl ':all';

=head1 DESCRIPTION

This module provides constraints the are usable with 
L<Data::FormValidator|https://metacpan.org/pod/Data::FormValidator>
parameter validation.

=head1 METHODS

=head2 valid_url

This constraint checks for a valid URL. It doesn't verify that the URL is
workable.

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

