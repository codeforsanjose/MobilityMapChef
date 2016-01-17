name "all_in_one"
description "Delivers web content"
run_list  'recipe[mobilitymap::application]',
          'recipe[mobilitymap::database]'
