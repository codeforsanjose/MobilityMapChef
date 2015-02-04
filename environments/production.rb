# 
# production environment
#
name 'production'
description 'This environment serves production ready material for CycleSafe'
cookbook_versions({
  "database" => "= 3.0.3",
  "logrotate" => "= 1.7.0",
  "sqlite" => "= 1.1.0"
})
default_attributes({
  'cyclesafe_chef' => {
    'revision' => 'master'
  },
  'instance_role' => 'production'
})
