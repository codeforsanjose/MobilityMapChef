
#
# CycleSafe deployment script for handling deployments to servers
#   Wraps knife ssh
#

from optparse import OptionParser
import json, os

# configure option parser
parser = OptionParser()
parser.add_option("-u","--ssh-user", dest="username",
                  help="SSH user to perform deployment as")
parser.add_option("-n", "--node-name", dest="nodename",
                  help="Node name string match for deployment")
parser.add_option("-g","--repository", dest="repository",
                  help="Path to git repository to be used for deployment")
parser.add_option("-r","--revision", dest="revision", default="deploy",
                  help="Revision branch/tag for git repository (defaults to deploy)")
parser.add_option("-e","--environment", dest="environment", default="production",
                  help="Chef environment to be used to deploy")
(options, args) = parser.parse_args()

# setup json attributes
json_attributes = {'cyclesafe_chef': {'revision': options.revision}}

if options.repository != None:
  json_attributes['cyclesafe_chef']['repository'] = options.repository

# setup command strings
server_cmd = "echo \"%s\" > config.json && chef-client -j config.json" %json.dumps(json_attributes).replace('"','\\"')
knife_ssh_cmd = "knife ssh 'name:%s' '%s' -x %s --ssh-password" %(options.nodename,server_cmd,options.username)

print knife_ssh_cmd
run = raw_input("Is this the correct command? (y/n)> ")
if run.lower() == "y":
  os.system(knife_ssh_cmd)  
