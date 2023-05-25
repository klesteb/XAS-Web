#!perl

use Test::More tests => 20;

BEGIN {
	use_ok( 'XAS::Web' );
    use_ok( 'XAS::Model::Database::Uaf::Result::Access' );
    use_ok( 'XAS::Model::Database::Uaf::Result::Actions' );
    use_ok( 'XAS::Model::Database::Uaf::Result::Resources' );
    use_ok( 'XAS::Model::Database::Uaf::Result::Rights' );
    use_ok( 'XAS::Model::Database::Uaf::Result::RightsList' );
    use_ok( 'XAS::Model::Database::Uaf::Result::Users' );
    use_ok( 'XAS::Uaf::ACLRule' );
    use_ok( 'XAS::Uaf::Authenticate' );
    use_ok( 'XAS::Uaf::AuthorizeFactory' );
    use_ok( 'XAS::Uaf::Manager' );
    use_ok( 'XAS::Uaf::User' );
    use_ok( 'XAS::Web::CheckParameters' );
    use_ok( 'XAS::Web::Constraints::JsonBool' );
    use_ok( 'XAS::Web::Constraints::ValidEmail' );
    use_ok( 'XAS::Web::Constraints::ValidUrl' );
    use_ok( 'XAS::Web::Profiles' );
    use_ok( 'XAS::Web::Profiles::Search' );
    use_ok( 'XAS::Web::Search' );
    use_ok( 'XAS::Web::Validate' );
}

diag( "Testing XAS::Web $XAS::Web::VERSION, Perl $], $^X" );
