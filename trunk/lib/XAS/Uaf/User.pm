package XAS::Uaf::User;

our $VERSION = '0.02';

use 5.8.8;

use JSON;
use Try::Tiny;
use DateTime;
use Params::Validate ':all';
use XAS::Model::Database
    schema => 'XAS::Model::Database::Uaf',
    tables => ':all'
;

use XAS::Class
  version   => $VERSION,
  base      => 'Scaffold::Uaf::User XAS::Base',
  codec     => 'JSON',
  utils     => 'db2dt',
  messages => {
      nouser => 'unable to find %s',
      error => '%s'
  }
;

Params::Validate::validation_options(
    on_fail => sub {
        my $param = shift;
        my $class = __PACKAGE__;
        XAS::Base::validation_exception($param, $class);
    }
);

use Data::Dumper;

# ----------------------------------------------------------------------
# Public Methods
# ----------------------------------------------------------------------

sub to_data {
    my ($self) = shift;

    my $data;
    my $expiration = $self->attribute('expiration');
    my $last_accessed = $self->attribute('last_accessed');

    $expiration =~ s/T/ /;
    $last_accessed =~ s/T/ /;

    $data->{username}      = $self->username;
    $data->{user_id}       = $self->attribute('user_id');
    $data->{password}      = $self->attribute('password');
    $data->{description}   = $self->attribute('description');
    $data->{account}       = $self->attribute('account');
    $data->{salt}          = $self->attribute('salt');
    $data->{attempts}      = $self->attribute('attempts');
    $data->{pwd_lifetime}  = $self->attribute('pwd_lifetime');
    $data->{pwd_change}    = $self->attribute('pwd_change');
    $data->{flags}         = $self->attribute('flags');
    $data->{expiration}    = db2dt($expiration);
    $data->{last_accessed} = db2dt($last_accessed);
    $data->{access_type}   = $self->attribute('access_type');
    $data->{rights_type}   = $self->attribute('rights_type');
    $data->{access}        = $self->attribute('access');
    $data->{rightslist}    = $self->attribute('rightslist');

    return $data;

}

sub update {
    my ($self, $schema) = @_;

    $self->_save_user_rec($schema);

}

# ------------------------------------------------------------------------
# Private methods
# ------------------------------------------------------------------------

sub init {
    my $class = shift;

    my $v;
    my $handle;
    my $self = $class->SUPER::init(@_);

    my %p = validate(@_,
        {
            -json     => {optional => 1},
            -data     => {optional => 1},
            -userid   => {optional => 1},
            -username => {optional => 1},
            -handle   => {optional => 1}
        }
    );

    $self->{config} = \%p;
    $handle = $p{'-handle'};

    if (defined($v = delete($p{'-username'}))) {

        $self->_load_with_username($v, $handle);

    } elsif (defined($v = delete($p{'-userid'}))) {

        $self->_load_with_userid($v, $handle);

    } elsif (defined($v = delete($p{'-json'}))) {

        $self->_load_with_json($v);

    } elsif (defined($v = delete($p{'-data'}))) {

        $self->_load_with_data($v);

    } else {

        $self = undef;

    }

    return $self;

}

sub _load_with_username {
    my ($self, $username, $handle) = @_;

    my $row;
    my @rights;
    my $access;

    if ($row = Users->find($handle, { username => $username })) {

        $self->{username} = $row->username;
        $self->_load_user_rec($row);

    } else {

        $self->throw_msg(
            'xas.uaf.user.load_with_username',
            'nouser',
            $username
        );

    }

}

sub _load_with_userid {
    my ($self, $userid, $handle) = @_;

    my $row;
    my $access;
    my @rights;

    if ($row = Users->find($handle, { id => $userid })) {

        $self->{username} = $row->username;
        $self->_load_user_rec($row);

    } else {

        $self->throw_msg(
            'xas.uaf.user.load_with_userid',
            'nouser',
            $userid
        );

    }

}

sub _load_with_json {
    my ($self, $data) = @_;

    my $items = decode($data);

    $self->_load_with_data($items);

}

sub _load_with_data {
    my ($self, $data) = @_;

    $self->{username} = delete($data->{username});

    while (my ($key, $value) = each(%$data)) {

        $self->attribute($key, $value);

    }

}

sub _load_user_rec {
    my ($self, $row) = @_;

    my $access;
    my $rights;
    my $rightslist;

    $self->attribute('password',      $row->password);
    $self->attribute('description',   $row->description);
    $self->attribute('account',       $row->account);
    $self->attribute('salt',          $row->salt);
    $self->attribute('attempts',      $row->attempts);
    $self->attribute('pwd_lifetime',  $row->pwd_lifetime);
    $self->attribute('pwd_change',    $row->pwd_change);
    $self->attribute('flags',         $row->flags);
    $self->attribute('expiration',    $row->expiration);
    $self->attribute('last_accessed', $row->last_accessed);
    $self->attribute('access_type',   $row->access_type);
    $self->attribute('rights_type',   $row->rights_type);
    $self->attribute('user_id',       $row->id);

    $access->{sunday}    = $row->access->sunday;
    $access->{monday}    = $row->access->monday;
    $access->{tuesday}   = $row->access->tuesday;
    $access->{wednesday} = $row->access->wednesday;
    $access->{thursday}  = $row->access->thursday;
    $access->{friday}    = $row->access->friday;
    $access->{saturday}  = $row->access->saturday;

    $self->attribute('access', $access);

    $rights = $row->rights->search_related('rightslist')->search;

    while (my $right = $rights->next) {

        my $x = {
            action   => $right->actions->name,
            resource => $right->resources->name
        };

        push(@{$rightslist}, $x);

    }

    $self->attribute('rightslist', $rightslist);

}

sub _save_user_rec {
    my ($self, $handle) = @_;

    my $rec;

    try {

        if ($rec = Users->find($handle, { username => $self->username })) {

            $rec->attempts($self->attribute('attempts'));
            $rec->last_accessed($self->attribute('last_accessed'));

#            $handle->changeset_user($rec->id);
            $handle->txn_do(sub {
                $rec->update;
            });

        }

    } catch {

        my $ex = $_;

        die $ex;

    };

}

1;

