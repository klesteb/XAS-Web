package # hide from CPAN
  XAS::Model::Database::Uaf::Result::RightsList;

our $VERSION = '0.01';

use XAS::Class
  version => $VERSION,
  base    => 'DBIx::Class::Core',
  mixin   => 'XAS::Model::DBM'
;

__PACKAGE__->load_components( qw/ InflateColumn::DateTime OptimisticLocking / );
__PACKAGE__->table( 'rightslist' );
__PACKAGE__->add_columns(
    id => {
        data_type         => 'bigint',
        is_auto_increment => 1,
        sequence          => 'rightslist_id_seq',
        is_nullable       => 0
    },
    rights_id => {
        data_type   => 'bigint',
        is_nullable => 0
    },
    action_id => {
        data_type   => 'bigint',
        is_nullable => 0
    },
    resource_id =>{
        data_type   => 'bigint',
        is_nullable => 0
    },
    revision => {
        data_type    => 'integer',
        dfault_value => 1,
        is_nullable  => 0
    }
);

__PACKAGE__->set_primary_key( 'id' );
__PACKAGE__->optimistic_locking_strategy('version');
__PACKAGE__->optimistic_locking_version_column('revision');

__PACKAGE__->belongs_to( 
    rights => 'XAS::Model::Database::Uaf::Rights', 
    { 'foreign.id' => 'self.rights_id' } 
);
__PACKAGE__->has_one( 
    actions => 'XAS::Model::Database::Uaf::Actions', 
    { 'foreign.id' => 'self.action_id' },
    { 'cascade_delete' => 0 }
);
__PACKAGE__->has_one( 
    resources => 'XAS::Model::Database::Uaf::Resources', 
    { 'foreign.id' => 'self.resource_id' },
    { 'cascade_delete' => 0 }
);

sub table_name {
    return __PACKAGE__;
}

1;
