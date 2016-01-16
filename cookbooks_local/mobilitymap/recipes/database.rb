#
# cookbook: mobilitymap
# recipe  : database
#

directory 'srv'

file '/srv/database.txt' do
  content 'HELLO DATABASE'
end 
