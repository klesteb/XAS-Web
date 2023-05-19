#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'XAS::Web' );
}

diag( "Testing XAS::Web $XAS::Web::VERSION, Perl $], $^X" );
