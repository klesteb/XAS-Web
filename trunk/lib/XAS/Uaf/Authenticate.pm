package XAS::Uaf::Authenticate;

our $VERSION = '0.01';

use DateTime;
use XAS::Uaf::User;
use Scaffold::Constants 'TOKEN_ID';

use XAS::Class
  version   => $VERSION,
  base      => 'Scaffold::Uaf::Authenticate',
  utils     => 'dotid, :validation',
  mixins    => 'uaf_is_valid uaf_validate uaf_invalidate uaf_check_credentials',
;

use Data::Dumper;

# ----------------------------------------------------------------------
# Public Methods
# ----------------------------------------------------------------------

sub uaf_is_valid {
    my ($self) = @_;

    my $day;
    my $data;
    my $hour;
    my $hours;
    my $token;
    my $access;
    my $old_ip;
    my $old_token;
    my $new_token;
    my $expiration;
    my $last_access;
    my $user = undef;
    my $lockmgr = $self->scaffold->lockmgr;
    my $ip = $self->scaffold->request->address;
    my $dt = DateTime->now(time_zone => 'local');

    if ($token = $self->stash->cookies->get(TOKEN_ID)) {

        $new_token = $token->value;
        $old_token = $self->scaffold->session->get('uaf_token') || '';
        $old_ip = $self->scaffold->session->get('uaf_remote_ip') || '';

        # This should work for just about everything except a load
        # balancing, natted firewall. And yeah, they do exist.

        if (($new_token eq $old_token) and ($ip eq $old_ip)) {

            $day = lc($dt->day_name);
            $hour = $dt->hour;

            if ($data = $self->scaffold->session->get('uaf_user')) {

                $user = XAS::Uaf::User->new(-data => $data);

                $last_access = $user->attribute('last_accessed');
                $expiration = $user->attribute('expiration');
                $access = $user->attribute('access');

                $user->attribute('last_accessed', $dt);
                $data = $user->to_data;
                $self->scaffold->session->set('uaf_user', $data);

                # check the accounts status

                if ($dt > $expiration) {

                    $self->throw_msg(
                        dotid($self->class) . '.expiredacct',
                        'expiredacct'
                    );

                }

                if (substr($access->{$day}, $hour, 1) ne 'Y') {

                    $self->throw_msg(
                        dotid($self->class) . '.noaccess',
                        'noaccess'
                    );

                }

                if ($last_access->epoch < ($dt->epoch - $self->uaf_timeout)) {

                    $self->throw_msg(
                        dotid($self->class) . '.sessionend',
                        'sessionend'
                    );

                }

            }

        }

    }

    return $user;

}

sub uaf_validate {
    my $self = shift;
    my ($username, $password) = validate_params(@_, [1,1]);

    my $user;
    my $data;
    my $attempts;
    my $ip = $self->scaffold->request->address;
    my $dt = DateTime->now(time_zone => 'local');

    if ($user = $self->uaf_check_credentials($username, $password)) {

        $attempts = $self->scaffold->session->get('uaf_login_attempts');

        $user->attribute('last_accessed', $dt);
        $user->attribute('attempts', $attempts);
        $data = $user->to_data;

        $self->scaffold->session->set('uaf_user', $data);
        $self->scaffold->session->set('uaf_remote_ip', $ip);

    }

    return $user;

}

sub uaf_check_credentials {
    my $self = shift;
    my ($username, $password) = validate_params(@_, [1,1]);

    my $user;
    my $data;
    my $handle = $self->scaffold->database->{$self->uaf_handle};

    $user = XAS::Uaf::User->new(-handle => $handle, -username => $username);
    if ($user) {

        $user = undef unless ($user->attribute('password') eq $password);

    }

    return $user;

}

sub uaf_invalidate {
    my ($self) = @_;

    my $user;
    my $data;
    my $lockmgr = $self->scaffold->lockmgr;
    my $schema = $self->scaffold->database->{desktop};

    if ($data = $self->scaffold->session->get('uaf_user')) {

        $user = XAS::Uaf::User->new(-data => $data);
        $user->update($schema);

    }

    $self->scaffold->session->expire();
    $self->stash->cookies->delete(TOKEN_ID);

}

1;

