name "database"
description "Delivers web content"
run_list "recipe[cyclesafe_chef::database]", "recipe[cyclesafe_chef::sysadmins]"
