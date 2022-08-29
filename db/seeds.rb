Role.destroy_all
Role.create!([
  {
    id: 1,
    name: 'admin'
  },
  {
    id: 2,
    name: 'user'
  },
  {
    id: 3,
    name: 'ta'
  }
])

ActiveRecord::Base.connection.reset_pk_sequence!('roles')