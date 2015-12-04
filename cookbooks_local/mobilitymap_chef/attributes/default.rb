
default[:mobilitymap][:user] = 'mobilitymap'
default[:mobilitymap][:group] = 'mobilitymap'
default[:mobilitymap][:debug_mode] = false

# app
default[:mobilitymap][:app][:collectstatic] = 'collectstatic --noinput'
default[:mobilitymap][:app][:requirements_file] = 'requirements.txt'
default[:mobilitymap][:app][:directory] = '/srv/mobilitymap_app'
default[:mobilitymap][:app][:django_directory] = "#{node[:mobilitymap][:app][:directory]}/current"
default[:mobilitymap][:app][:local_settings_file] = "src/project/local_settings.py"
default[:mobilitymap][:app][:hostname] = 'mobilitymap-app'
default[:mobilitymap][:app][:repository] = 'https://github.com/codeforsanjose/mobilitymap.git'
default[:mobilitymap][:app][:packages] = ['gunicorn','pyopenssl','ndg-httpsclient','pyasn1','psycopg2']
default[:mobilitymap][:app][:name] = 'mobilitymap_app'
default[:mobilitymap][:app][:deploy_action] = 'deploy'
default[:mobilitymap][:app][:migrate] = false
default[:mobilitymap][:app][:wsgi_module] = 'src.project.wsgi'
default[:mobilitymap][:app][:static_files] = {'/static' => "#{node[:mobilitymap][:app][:django_directory]}/src/sa_web/static"}
default[:mobilitymap][:app][:db][:name] = '"shareabouts_v2"'
default[:mobilitymap][:app][:db][:adapter] = '"django.contrib.gis.db.backends.postgis"'
default[:mobilitymap][:app][:db][:user] = '"postgres"'
default[:mobilitymap][:app][:db][:address] = '"localhost"'
default[:mobilitymap][:app][:db][:port] = '5432'
default[:mobilitymap][:app][:shareabouts][:default_api] = true
default[:mobilitymap][:app][:shareabouts][:flavor] = '"mobilitymap"'
default[:mobilitymap][:app][:shareabouts][:dataset_root] = '"http://data.shareabouts.org/api/v2/demo-user/datasets/demo-data/"'
default[:mobilitymap][:app][:shareabouts][:dataset_key] = '"NTNhODE3Y2IzODlmZGZjMWU4NmU3NDhj"'
default[:mobilitymap][:app][:rest_framework][:paginate_by] = '500'
default[:mobilitymap][:app][:rest_framework][:paginate_by_param] = '"page_size"'
#default[:mobilitymap][:app][:settings]['NAME'] = '"shareabouts_v2"'
#default[:mobilitymap][:app][:settings]['ENGINE'] = '""'
#default[:mobilitymap][:app][:settings]['TIME_ZONE'] = '"America/New_York"'
#default[:mobilitymap][:app][:settings]['TEMPLATE_DEBUG'] = '"DEBUG"'
#default[:mobilitymap][:app][:settings]['EMAIL_ADDRESS'] = '"shareabouts@example.com"'
#default[:mobilitymap][:app][:settings]['EMAIL_BACKEND'] = '"django.core.mail.backends.console.EmailBackend"'
#default[:mobilitymap][:app][:settings]['EMAIL_NOTIFICATIONS_BCC'] = nil
#default[:mobilitymap][:app][:settings]['MAPQUEST_KEY'] = '"iFmjtd%7Cluur2g0bnl%2C25%3Do5-9at29u"'
default[:mobilitymap][:app][:settings]['BROKER_URL'] = '"django://"'

# api
default[:mobilitymap][:api][:requirements_file] = 'requirements.txt'
default[:mobilitymap][:api][:directory] = '/srv/mobilitymap_api'
default[:mobilitymap][:api][:hostname] = 'mobilitymap-api'
default[:mobilitymap][:api][:repository] = 'https://github.com/codeforsanjose/mobilitymap-api.git'
default[:mobilitymap][:api][:name] = 'mobilitymap_api'
default[:mobilitymap][:api][:db][:name] = 'default'
default[:mobilitymap][:api][:db][:adapter] = 'default'
default[:mobilitymap][:api][:db][:user] = 'default'
default[:mobilitymap][:api][:db][:address] = 'default'
default[:mobilitymap][:api][:db][:port] = 'default'

