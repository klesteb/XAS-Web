package XAS::Model::Database::Uaf::Result::Users;

our $VERSION = '0.01';
  
use XAS::Class
  version => $VERSION,
  base    => 'DBIx::Class::Core',
  mixin   => 'XAS::Model::DBM'
;

__PACKAGE__->load_components( qw/ InflateColumn::DateTime OptimisticLocking / );
__PACKAGE__->table( 'users' );
__PACKAGE__->add_columns(
    id => {
        data_type         => 'bigint',
        is_auto_increment => 1,
        sequence          => 'user_id_seq',
        is_nullable       => 0
    },
    username => {
        data_type     => 'varchar',
        size          => 32,
        is_nullable   => 0
    },
    password => {
        data_type     => 'varchar',
        size          => 32,
        is_nullable   => 0
    },
    fullname => {
        data_type     => 'varchar',
        size          => 64,
        is_nullable   => 1,
    },
    description => {
        data_type     => 'varchar',
        size          => 255,
        is_nullable   => 0
    },
    account => {
        data_type     => 'varchar',
        size          => 32,
        is_nullable   => 0
    },
    salt => {
        data_type     => 'varchar',
        size          => 32,
        is_nullable   => 0,
        default_value => 'w3s3cR7'
    },
    attempts => {
        data_type     => 'integer',
        is_nullable   => 0
    },
    pwd_lifetime => {
        data_type     => 'integer',
        is_nullable   => 1
    },
    pwd_change => {
        data_type     => 'datetime',
    },
    flags => {
        data_type     => 'integer',
        is_nullable   => 1
    },
    expiration => {
        data_type     => 'datetime',
        is_nullable   => 1
    },
    last_accessed => {
        data_type     => 'datetime',
        is_nullable   => 1
    },
    access_type => {
        data_type     => 'varchar',
        size          => 32,
        is_nullable   => 0,
        default_value => 'default'
    },
    rights_type => {
        data_type     => 'varchar',
        size          => 32,
        is_nullable   => 0,
        default_value => 'default'
    },
    revision => {
        data_type     => 'integer',
        default_value => 1,
        is_nullable   => 1
    }
);

__PACKAGE__->set_primary_key( 'id' );
__PACKAGE__->optimistic_locking_strategy('version');
__PACKAGE__->optimistic_locking_version_column('revision');
__PACKAGE__->add_unique_constraint(users_username_idx => ['username']);

__PACKAGE__->has_one( 
    access => 'XAS::Model::Database::Uaf::Access', 
    { 'foreign.name' => 'self.access_type' } 
);
__PACKAGE__->has_one( 
    rights => 'XAS::Model::Database::Uaf::Rights', 
    { 'foreign.name' => 'self.rights_type' } 
);

sub table_name {
    return __PACKAGE__;
}

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table->add_index(name => 'users_account_idx', fields => ['account']);

}

1;

