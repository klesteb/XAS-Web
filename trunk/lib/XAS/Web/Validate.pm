package XAS::Web::Validate;

our $VERSION = '0.01';

use XAS::Class
  debug     => 0,
  version   => $VERSION,
  base      => 'XAS::Base',
  mixin     => 'XAS::Web::CheckParameters',
  accessors => 'profile',
  utils     => 'dotid :validation',
;

#use Data::Dumper;

# ----------------------------------------------------------------------
# Public Methods
# ----------------------------------------------------------------------

sub check {
    my $self = shift;
    my ($multi) = validate_params(\@_, [
        { isa => 'Hash::MultiValue' },
    ]);

    $self->throw_msg(
        dotid($self->class) . '.notimplemented',
        'notimplemented',
    );
    
}

# ----------------------------------------------------------------------
# Private Methods
# ----------------------------------------------------------------------

sub init {
    my $class = shift;

    my $self = $class->SUPER::init(@_);

    return $self;

}

1;

__END__

=head1 NAME

XAS::Web::Validate - A base class to verify profiles.

=head1 SYNOPSIS

 package XAS::Web::Validate::Darkpan::Authors;

 our $VERSION = '0.01';

 use XAS::Web::Profiles;
 use XAS::Web::Profiles::Darkpan::Authors;

 use XAS::Class
      debug     => 0,
      version   => $VERSION,
      base      => 'XAS::Base',
      mixin     => 'XAS::Web::CheckParameters',
      accessors => 'profile',
      utils     => 'dotid :validation',
 ;

 sub check {
     my $self = shift;
     my ($multi) = validate_params(\@_, [
         { isa => 'Hash::MultiValue' },
     ]);

     my $params = $multi->as_hashref;

     return $self->check_parameters($params, 'authors');

 }

 sub init {
     my $class = shift;

     my $self = $class->SUPER::init(@_);

     my $profile = XAS::Web::Profiles::Darkpan::Authors->build();

     $self->{'profile'} = XAS::Web::Profiles->new($profile);

     return $self;

 }

 1;

=head1 DESCRIPTION

This modules is the base class to provide the validation routines for 
validating html form parameters. It must be overridden.

=head1 METHODS

=head2 new

This method initializes the module.

=head2 check($params)

This method will verify that the parameters is consitent with the profile.

=over 4

=item B<$params>

The parameters to verify against the profile.

=back

=head1 SEE ALSO

=over 4

=item L<XAS::Web::Profiles|XAS::Web::Profiles>

=item L<XAS::Web|XAS::Web>

=item L<XAS|XAS>

=back

=head1 AUTHOR

Kevin L. Esteb, E<lt>kevin@kesteb.usE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2012-2023 by Kevin L. Esteb

This is free software; you can redistribute it and/or modify it under
the terms of the Artistic License 2.0. For details, see the full text
of the license at http://www.perlfoundation.org/artistic_license_2_0.

=cut
