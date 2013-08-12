gitUrl     = node[:bitstarter_box][:bitstarter_app][:git_repo]
reference  = node[:bitstarter_box][:bitstarter_app][:reference]
targetDir  = node[:bitstarter_box][:bitstarter_app][:install_directory]
user       = node[:bitstarter_box][:user]
group      = node[:bitstarter_box][:group]
nvmVersion = node[:bitstarter_box][:nvm_version]   


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


 bash "npm-install express locally" do

 	cwd "/home/#{user}/#{targetDir}"

 	code <<-EOH
 	 source /home/#{user}/.nvm/nvm.sh
     nvm use #{nvmVersion}
 	 npm install express	
 	EOH
 end