# See http://docs.opscode.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "insert_node_name_here" # so the chef server can identify your user
client_key               "#{current_dir}/insert_client_key_name_here.pem" # the key associated with your user
validation_client_name   "cyclesafe" # 
validation_key           "#{current_dir}/cyclesafe.pem"
chef_server_url          "https://api.opscode.com/organizations/cyclesafe"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            [ ]

knife[:secret_file] = "#{current_dir}/encrypted_data_bag_secret"
