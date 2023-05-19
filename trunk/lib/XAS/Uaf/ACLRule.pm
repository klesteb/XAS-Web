package XAS::Uaf::ACLRule;

our $VERSION = '0.01';

use XAS::Class
  version => $VERSON,
  base    => 'Scaffold::Uaf::Rule'
;

# ----------------------------------------------------------------------
# Public Methods
# ----------------------------------------------------------------------

sub grants {
    my ($self, $user, $action, $resource) = @_;

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
    my ($self, $user, $action, $resource) = @_;

    # By default, deny everything.

    return 0;

}

# ----------------------------------------------------------------------
# Private Methods
# ----------------------------------------------------------------------

1;

__END__

