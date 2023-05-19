package XAS::Web::Constraints::JsonBool;

our $VERSION = '0.01';

use XAS::Class
  version   => $VERSION,
  base      => 'Badger::Exporter',
  constants => 'TRUE FALSE',
  exports => {
      all => 'json_bool',
      any => 'json_bool'
  }
;

# ----------------------------------------------------------------------
# Public Methods
# ----------------------------------------------------------------------

sub json_bool {

    return sub {
        my $dfv = shift;
        my $val = $dfv->get_current_constraint_value();
        return 1 if (ref($val) =~ /Boolean/i);
    };

}

# ----------------------------------------------------------------------
# Private Methods
# ----------------------------------------------------------------------

1;

__END__

=head1 NAME

XAS::Web::Constraints::JsonBool - An set of constraints for Data::FormValidator.

=head1 SYNOPSIS

 use XAS::Web::Constraints::JsonBool ':all';

=head1 DESCRIPTION

=over 4

=item json_bool

This routine check to see if the passed item is a JSON Boolean.

=back

=head1 SEE ALSO

=over 4

=item L<XAS::Web::Profiles|XAS::Web::Profiles>

=item L<XAS::Web|XAS::Web>

=item L<XAS|XAS>

=back

=head1 AUTHOR

Kevin Esteb, E<lt>kevin@kesteb.usE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011-2023 Kevin L. Esteb

This is free software; you can redistribute it and/or modify it under
the terms of the Artistic License 2.0. For details, see the full text
of the license at http://www.perlfoundation.org/artistic_license_2_0.

=cut

