name             'mobilitymap'
maintainer       'Mobility Map'
maintainer_email 'zpallin@gmail.com'
license          'All rights reserved'
description      'Installs/Configures cyclesafe_chef'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

unless defined?(Ridley::Chef::Cookbook::Metadata)
  source_url       'https://github.com/codeforsanjose/mobilitymap.git'
end

depends 'application'
depends 'application_python'
depends 'application_nginx'
depends 'apt'
depends 'database'
depends 'nginx'
depends 'nodejs'
depends 'locale'
depends 'logrotate'
depends 'poise'
depends 'postgis'
depends 'python'
depends 'runit'
depends 'sqlite'
depends 'users'
