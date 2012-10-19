require 'pathname'

load 'deploy' if respond_to?(:namespace) # cap2 differentiator

# Uncomment if you are using Rails' asset pipeline
load 'deploy/assets'

Dir['vendor/gems/*/recipes/*.rb','vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }


pn = Pathname.new("config/deploy_custom.rb")
p = ""
if pn.exist? then
  p = 'config/deploy_custom.rb'
else
  p = 'config/deploy'
end
load p # remove this line to skip loading any of the default tasks
