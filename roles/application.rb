name "application"
description "Delivers web content"
run_list "recipe[cyclesafe_chef::application]", "recipe[cyclesafe_chef::sysadmins]"
