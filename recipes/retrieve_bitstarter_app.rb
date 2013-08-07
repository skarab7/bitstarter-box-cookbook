gitUrl     = node[:bitstarter_box_cookbook][:bitstarter_app][:git_repo]
reference  = node[:bitstarter_box_cookbook][:bitstarter_app][:reference]
targetDir  = node[:bitstarter_box_cookbook][:bitstarter_app][:install_directory]
user       = node[:bitstarter_box_cookbook][:user]
group      = node[:bitstarter_box_cookbook][:group]



directory "/home/#{user}/#{targetDir}" do
	owner user
	group group
	mode 00755
	action :create
	recursive true
end



git "/home/#{user}/#{targetDir}" do
   user  user
   group group
   
   repository gitUrl
   reference "master"
   action :sync
 end