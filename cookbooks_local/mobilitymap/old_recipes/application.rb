
# include defaults
include_recipe 'mobilitymap'
include_recipe 'runit'
include_recipe 'python'

# install dependencies
package 'libffi-dev'

# assign secret_key values
secret_key = data_bag_item('keys','secret_key')['key']
database_password = data_bag_item('passwords','database')['mysql']

# second secret_key escaped for supervisord pickiness!
secret_key_supervisord = "#{secret_key.gsub(/%/,'%%')}";

# easy variable references
sock_dir = "#{node[:mobilitymap][:directory]}/run"
app_name = 'cyclesafe'
django_dir = "#{node[:mobilitymap][:directory]}/current"
sock_file = "#{sock_dir}/#{app_name}.sock"
shared_dir = "#{node[:mobilitymap][:directory]}/shared/env/"
wsgi_module = "#{app_name}.wsgi:application"
settings_module = "#{app_name}.settings"
log_level = node[:mobilitymap][:log_level] || 'debug'
num_workers = 3

# create shared directory
directory "#{node[:mobilitymap][:directory]}/shared" do
  user node[:mobilitymap][:user]
  group node[:mobilitymap][:group]
  mode '0775'
  recursive true
end

# set environment variable
ENV['SECRET_KEY'] = secret_key

# sock directory creation
directory sock_dir do
  action :create
  user node[:mobilitymap][:user]
  group node[:mobilitymap][:group]
  mode 0755
  recursive true
end

# install django
application app_name do
  path node[:mobilitymap][:directory]
  owner node[:mobilitymap][:user] 
  group node[:mobilitymap][:group]
  repository node[:mobilitymap][:repository]
  revision node[:mobilitymap][:revision] if node[:mobilitymap][:revision]
  migrate true
  rollback_on_error false
  action :"#{node[:mobilitymap][:deploy_action]}"

  django do
    requirements 'requirements.txt'
    debug node[:mobilitymap][:debug_mode] == 'true' ? true : false
    packages ['gunicorn']
    settings_template 'settings.py.erb'
    
    database do
      database 'cyclesafe'
      adapter 'mysql'
      username 'cyclesafe'
      password database_password
      host '127.0.0.1'
      port 3306
    end
  end

  gunicorn do
    host node[:mobilitymap][:hostname]
    app_module wsgi_module
    socket_path sock_file
    autostart true
    virtualenv shared_dir
    environment ({"SECRET_KEY"=>secret_key_supervisord})
  end

  nginx_load_balancer do
    server_name node[:mobilitymap][:hostname]
    port 80
    application_socket ["#{sock_file} fail_timeout=0"]
    static_files '/static' => 'app/static'
  end

  only_if { node[:mobilitymap][:repository] != nil }
end
