
include_recipe 'mobilitymap'

# mm app and api custom configs
mm_app = node[:mobilitymap][:app]
mm_api = node[:mobilitymap][:api]

# database password setting
database_password = data_bag_item('passwords','database')['postgresql']

user node[:mobilitymap][:user] do
  comment 'Mobility Map User'
  home node[:mobilitymap][:app][:directory]
  shell '/bin/bash'
  password data_bag_item('passwords','users')['mobilitymap']
end

# basic includes
include_recipe 'apt'
package 'git'
package 'libffi-dev'
include_recipe 'runit'
include_recipe 'python'

# postgis config
node.override['locale']['lang'] = 'en_AU.UTF-8'
include_recipe 'locale::default'
include_recipe 'postgis::default'

# database key
secret_key = 'key' #data_bag_item('keys','secret_key')['key']
secret_key = 'test' #data_bag_item('passwords','database')
secret_key_supervisord = "#{secret_key.gsub(/%/,'%%')}"

# easy variable references
sock_dir = "#{mm_app[:directory]}/run"
app_name = mm_app[:hostname]
django_dir = "#{mm_app[:directory]}/current"
sock_file = "#{sock_dir}/#{app_name}.sock"
shared_dir = "#{mm_app[:directory]}/shared/env/"
wsgi_module = mm_app[:wsgi_module] #"project.wsgi:application"
settings_module = "#{app_name}.settings"
log_level = mm_app[:log_level] || 'debug'
num_workers = 3

# create shared directory
directory "#{mm_app[:directory]}/shared" do
  owner node[:mobilitymap][:user]
  group node[:mobilitymap][:group]
  mode '0775'
  recursive true
end

# secret key
ENV['SECRET_KEY'] = 'secret_key'

# sock directory creation
directory sock_dir do
  action :create
  owner node[:mobilitymap][:user]
  group node[:mobilitymap][:group]
  mode 0755
  recursive true
end

# install django
application app_name do
  path mm_app[:directory]
  owner node[:mobilitymap][:user]
  group node[:mobilitymap][:group]
  repository mm_app[:repository]
  revision mm_app[:revision] if mm_app[:revision]
  migrate mm_app[:migrate]
  rollback_on_error false
  action :"#{mm_app[:deploy_action]}"

  django do
    requirements mm_app[:requirements_file]
    local_settings_file mm_app[:local_settings_file]
    debug mm_app[:debug_mode] == 'true' ? true : false
    packages mm_app[:packages]
    settings_template 'local_settings.py.erb'
    settings ({
      'shareabouts' => mm_app[:shareabouts],
      'rest_framework' => mm_app[:rest_framework],
      'settings' => mm_app[:settings] 
    })

    database do
      database mm_app[:db][:name] if mm_app[:db][:name]
      adapter mm_app[:db][:adapter] # postgresql
      username mm_app[:db][:user]
      password "'#{database_password}'"
      host mm_app[:db][:address]
      port mm_app[:db][:port]
    end
  end

  gunicorn do
    directory mm_app[:django_directory]
    host mm_app[:hostname]
    app_module wsgi_module
    socket_path sock_file
    autostart true
    virtualenv shared_dir
    environment ({"SECRET_KEY"=>secret_key_supervisord})
  end

  nginx_load_balancer do
    server_name mm_app[:hostname]
    port 80
    application_socket ["#{sock_file} fail_timeout=0"]
    static_files mm_app[:static_files]
  end

  only_if { mm_app[:repository] != nil }
end

# I have to do collectstatic separately as a hack because
# the application_python django provider will only do it from
# the release directory and you cannot modify it.
execute 'collect static hack' do
  cwd "#{django_dir}/src"
  command "#{shared_dir}/bin/python manage.py collectstatic --noinput"
  user node[:mobilitymap][:user]
  group node[:mobilitymap][:group]
end

execute 'npm install' do
  cwd django_dir
end

execute 'npm install' do
  cwd django_dir
  user node[:mobilitymap][:user]
  group node[:mobilitymap][:group]
end

