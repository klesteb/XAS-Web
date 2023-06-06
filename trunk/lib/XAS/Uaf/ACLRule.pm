package XAS::Uaf::ACLRule;

our $VERSION = '0.01';

use XAS::Class
  version => $VERSON,
  base    => 'Scaffold::Uaf::Rule',
  utils   => ':validation',
;

# ----------------------------------------------------------------------
# Public Methods
# ----------------------------------------------------------------------

sub grants {
    my $self = shift;
    my ($user, $action, $resource) = validate_params(@_, [1,1,1]);

    my $rights;
    my $stat = 0;
    my $rightslist = $user->attribute('rightslist');

    foreach $rights (@{$rightslist}) {

        if ($rights->{resource} eq $resource) {

            if (($rights->{action} eq $action) or
                ($rights->{action} eq 'control')) {

                $stat = 1;
                last;

            }

        }

    }

    return $stat;

}

sub denies {
    my $self = shift;
    my ($user, $action, $resource) = validate_params(@_, [1,1,1]);

    # By default, deny everything.

    return 0;

}

# ----------------------------------------------------------------------
# Private Methods
# ----------------------------------------------------------------------

1;

__END__

=head1 NAME

XAS::Web::Uaf::ACLRule - This module provides basic access to an ACL.
  
=head1 SYNOPSIS

 use XAS::Apps::Service::Testd;

 my $app = XAS::Apps::Service::Testd->new();

 exit $app->run();

=head1 DESCRIPTION

This module module provides a test micro service.
  
=head1 SEE ALSO

=over 4

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

