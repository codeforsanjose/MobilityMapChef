#
# cookbook: mobilitymap
# recipe  : server
#

directory 'srv'

file '/srv/server.txt' do
  content 'HELLO SERVER'
end 
