package XAS::Model::Database::Uaf::Result::Rights;

our $VERSION = '0.01';

use XAS::Class
  version => $VERSION,
  base    => 'DBIx::Class::Core',
  mixin   => 'XAS::Model::DBM',
;

__PACKAGE__->load_components( qw/ InflateColumn::DateTime OptimisticLocking / );
__PACKAGE__->table( 'rights' );
__PACKAGE__->add_columns(
    id => {
        data_type         => 'bigint',
        is_auto_increment => 1,
        sequence          => 'rights_id_seq',
        is_nullable       => 0
    },
    name => {
        data_type     => 'varchar',
        size          => 32,
        is_nullable   => 0,
        default       => 'default'
    },
    description => {
        data_type     => 'varchar',
        size          => 255,
        is_nullable   => 1
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
__PACKAGE__->add_unique_constraint(rights_name_idx => ['name']);

__PACKAGE__->belongs_to( 
    users => 'XAS::Model::Database::Uaf::Users', 
    { 'foreign.rights_type' => 'self.name' } 
);
__PACKAGE__->has_many( 
    rightslist => 'XAS::Model::Database::Uaf::RightsList', 
    { 'foreign.rights_id' => 'self.id' }
);

sub table_name {
    return __PACKAGE__;
}

1;
