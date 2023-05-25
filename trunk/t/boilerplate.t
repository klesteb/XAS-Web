#!perl -T

use strict;
use warnings;
use Test::More;

unless ( $ENV{RELEASE_TESTING} ) {
    plan( skip_all => "Author tests not required for installation" );
} else {
    plan tests => 22;
}
        
sub not_in_file_ok {
    my ($filename, %regex) = @_;
    open( my $fh, '<', $filename )
        or die "couldn't open $filename for reading: $!";

    my %violated;

    while (my $line = <$fh>) {
        while (my ($desc, $regex) = each %regex) {
            if ($line =~ $regex) {
                push @{$violated{$desc}||=[]}, $.;
            }
        }
    }

    if (%violated) {
        fail("$filename contains boilerplate text");
        diag "$_ appears on lines @{$violated{$_}}" for keys %violated;
    } else {
        pass("$filename contains no boilerplate text");
    }
}

sub module_boilerplate_ok {
    my ($module) = @_;
    not_in_file_ok($module =>
        'the great new $MODULENAME'   => qr/ - The great new /,
        'boilerplate description'     => qr/Quick summary of what the module/,
        'stub function definition'    => qr/function[12]/,
    );
}

TODO: {
  local $TODO = "Need to replace the boilerplate text";

  not_in_file_ok(README =>
    "The README is used..."       => qr/The README is used/,
    "'version information here'"  => qr/to provide version information/,
  );

  not_in_file_ok(Changes =>
    "placeholder date/time"       => qr(Date/time)
  );

  module_boilerplate_ok('lib/XAS/Web.pm');
  module_boilerplate_ok('lib/XAS/Model/Database/Uaf/Result/Access.pm');
  module_boilerplate_ok('lib/XAS/Model/Database/Uaf/Result/Actions.pm');
  module_boilerplate_ok('lib/XAS/Model/Database/Uaf/Result/Resources.pm');
  module_boilerplate_ok('lib/XAS/Model/Database/Uaf/Result/Rights.pm');
  module_boilerplate_ok('lib/XAS/Model/Database/Uaf/Result/RightsList.pm');
  module_boilerplate_ok('lib/XAS/Model/Database/Uaf/Result/Users.pm');
  module_boilerplate_ok('lib/XAS/Uaf/ACLRule.pm');
  module_boilerplate_ok('lib/XAS/Uaf/Authenticate.pm');
  module_boilerplate_ok('lib/XAS/Uaf/AuthorizeFactory.pm');
  module_boilerplate_ok('lib/XAS/Uaf/Manager.pm');
  module_boilerplate_ok('lib/XAS/Uaf/User.pm');
  module_boilerplate_ok('lib/XAS/Web/CheckParameters.pm');
  module_boilerplate_ok('lib/XAS/Web/Constraints/JsonBool.pm');
  module_boilerplate_ok('lib/XAS/Web/Constraints/ValidEmail.pm');
  module_boilerplate_ok('lib/XAS/Web/Constraints/ValidUrl.pm');
  module_boilerplate_ok('lib/XAS/Web/Profiles.pm');
  module_boilerplate_ok('lib/XAS/Web/Profiles/Search.pm');
  module_boilerplate_ok('lib/XAS/Web/Search.pm');
  module_boilerplate_ok('lib/XAS/Web/Validate.pm');

}

