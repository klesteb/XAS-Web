package XAS::Uaf::Manager;

our $VERSION = '0.01';

use 5.8.8;

use XAS::Class
  version => $VERSION,
  base    => 'Scaffold::Uaf::Manager',
  mixins  => 'XAS::Uaf::Authenticate',
;

# ----------------------------------------------------------------------
# Public Methods
# ----------------------------------------------------------------------

# ----------------------------------------------------------------------
# Private Methods
# ----------------------------------------------------------------------

1;

__END__

=head1 NAME

XAS::Uaf::Manager - A plugin to do authentication within the XAS framework

=head1 DESCRIPTION

This plugin is automatically loaded when authentication is desired. It 
checks the current session to see if it is authenticatied. If not it will 
redirect back to a "login" url to force authentication or it will redirect to
a "denied" url when login attempts are exceeded.

This plugin understands the following config settings:

 uaf_limit        - The number of login attempts
 uaf_filter       - A reqex of non authenticated urls
 uaf_login_rootp  - The url to redirect to for login processing
 uaf_denied_rootp - The url to redirect to for login denial

=head1 METHODS

=over 4

=item pre_action

Checks to see if the current session is authenticated, redirects as needed.

=back

=head1 DEPENDENICES

 XAS::Uaf::Authenticate

=head1 SEE ALSO

 Scaffold::Uaf::Authenticate

=head1 AUTHOR

Kevin L. Esteb E<lt>kevin@kesteb.usE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2012-2023 Kevin L. Esteb
  
This is free software; you can redistribute it and/or modify it under
the terms of the Artistic License 2.0. For details, see the full text
of the license at http://www.perlfoundation.org/artistic_license_2_0.

=cut
