package # hide from CPAN
  XAS::Model::Database::Uaf::Result::Actions;

our $VERSION = '0.01';

use XAS::Class
  version => $VERSION,
  base    => 'DBIx::Class::Core',
  mixin   => 'XAS::Model::DBM'
;

__PACKAGE__->load_components( qw/ InflateColumn::DateTime OptimisticLocking / );
__PACKAGE__->table( 'actions' );
__PACKAGE__->add_columns(
    id => {
        data_type         => 'bigint',
        is_auto_increment => 1,
        sequence          => 'actions_id_seq',
        is_nullable       => 0
    },
    name => {
        data_type    => 'varchar',
        size         => 255,
        is_nulllable => 0
    },
    revision => {
        data_type     => 'integer',
        default_value => 1,
        is_nullable   => 0
    }
);

__PACKAGE__->set_primary_key( 'id' );
__PACKAGE__->optimistic_locking_strategy('version');
__PACKAGE__->optimistic_locking_version_column('revision');
__PACKAGE__->belongs_to( rights => 'XAS::Model::Database::Uaf::Rights', { 'foreign.action_id' => 'self.id' });
__PACKAGE__->add_unique_constraint(actions_name_idx => ['name']);

sub table_name {
    return __PACKAGE__;
}

1;

