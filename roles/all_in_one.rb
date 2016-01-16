name "all_in_one"
description "Delivers web content"
run_list "recipe[mobility_map::server],recipe[mobility_map::server]"
