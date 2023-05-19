package XAS::Model::Database::Uaf::Result::Access;

our $VERSION = '0.01';

use XAS::Class
  version => $VERSION,
  base    => 'DBIx::Class::Core',
  mixin   => 'XAS::Model::DBM',
;

__PACKAGE__->load_components( qw/ InflateColumn::DateTime OptimisticLocking / );
__PACKAGE__->table( 'access' );
__PACKAGE__->add_columns(
    id => {
        data_type         => 'bigint',
        is_auto_increment => 1,
        sequence          => 'access_id_seq',
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
    monday => {
        data_type     => 'varchar',
        size          => 24,
        is_nullable   => 0,
        default_value =>'YYYYYYYYYYYYYYYYYYYYYYYYY'
    },
    tuesday => {
        data_type     => 'varchar',
        size          => 24,
        is_nullable   => 0,
        default_value =>'YYYYYYYYYYYYYYYYYYYYYYYYY'
    },
    wednesday => {
        data_type     => 'varchar',
        size          => 24,
        is_nullable   => 0,
        default_value =>'YYYYYYYYYYYYYYYYYYYYYYYYY'
    },
    thursday => {
        data_type     => 'varchar',
        size          => 24,
        is_nullable   => 0,
        default_value =>'YYYYYYYYYYYYYYYYYYYYYYYYY'
    },
    friday => {
        data_type     => 'varchar',
        size          => 24,
        is_nullable   => 0,
        default_value =>'YYYYYYYYYYYYYYYYYYYYYYYYY'
    },
    saturday => {
        data_type     => 'varchar',
        size          => 24,
        is_nullable   => 0,
        default_value =>'YYYYYYYYYYYYYYYYYYYYYYYYY'
    },
    sunday => {
        data_type     => 'varchar',
        size          => 24,
        is_nullable   => 0,
        default_value =>'YYYYYYYYYYYYYYYYYYYYYYYYY'
    },
    revision => {
        data_type     => 'integer',
        default_value => 1,
        is_nullable   => 1,
    }
);

__PACKAGE__->set_primary_key( 'id' );
__PACKAGE__->belongs_to( users => 'XAS::Model::Database::Uaf::Users', { 'foreign.access_type' => 'self.name' } );
__PACKAGE__->optimistic_locking_strategy('version');
__PACKAGE__->optimistic_locking_version_column('revision');
__PACKAGE__->add_unique_constraint(access_name_idx => ['name']);

sub table_name {
    return __PACKAGE__;
}

1;
