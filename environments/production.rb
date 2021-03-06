# 
# production environment
#
name 'production'
description 'This environment serves production ready material for CycleSafe'
cookbook_versions({
  "application" => "= 4.1.4",
  "cyclesafe_chef" => "= 0.1.6",
  "database" => "= 3.0.3",
  "logrotate" => "= 1.7.0",
  "poise" => "= 1.0.12",
  "sqlite" => "= 1.1.0",
  "users" => "= 1.7.0"
})
default_attributes({
  'cyclesafe_chef' => {
    'revision' => 'master'
  },
  'instance_role' => 'production',
  'authorization' => { 
    'sudo' => {
      'groups' => ['sysadmin']
    }
  },
  'openssh' => {
    'server' => {
      'match' => {
        'Group sysadmin' => {
          'password_authentication' => 'no'
        }
      }
    }
  }
})
