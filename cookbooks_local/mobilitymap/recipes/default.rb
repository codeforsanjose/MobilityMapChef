#
# Cookbook Name:: mobilitymap
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

#include_recipe 'poise-python'
include_recipe 'postgresql'

directory node[:mobilitymap][:checkout_dir] do
  owner node[:mobilitymap][:user]
  owner node[:mobilitymap][:group]
  recursive true
end

# install python
python_runtime '2'
python_virtualenv node[:mobilitymap][:shared_dir]

package 'postgis'
package 'binutils'
package 'libproj-dev'
package 'gdal-bin'
package 'python-gdal'

python_pip 'psycopg2' do
  virtualenv node[:mobilitymap][:shared_dir]
end

