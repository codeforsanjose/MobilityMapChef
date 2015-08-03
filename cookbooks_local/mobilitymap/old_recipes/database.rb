

include_recipe 'cyclesafe_chef'

database_password = data_bag_item('passwords','mobilitymapapi')['postgresql']

postgresql_database 'database_name' do
  connection(
    :host     => '127.0.0.1',
    :port     => 5432,
    :username => 'postgres',
    :password => node['postgresql']['password']['postgres']
  )
end
