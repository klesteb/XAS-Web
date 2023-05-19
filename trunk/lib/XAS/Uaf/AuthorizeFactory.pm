package XAS::Uaf::AuthorizeFactory;

use XAS::Uaf::ACLRule;

use XAS::Class
  version => $VERSION,
  base    => 'Scaffold::Uaf::AuthorizeFactory'
;

# ----------------------------------------------------------------------
# Public Methods
# ----------------------------------------------------------------------

sub rules {
    my $self = shift;

	$self->add_rule(XAS::Uaf::ACLRule->new());

}

# ----------------------------------------------------------------------
# Private Methods
# ----------------------------------------------------------------------

1;

__END__
  