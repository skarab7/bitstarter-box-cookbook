
targetDir  = node[:bitstarter_box][:bitstarter_app][:install_directory]
user       = node[:bitstarter_box][:user]
group      = node[:bitstarter_box][:group]
nvmVersion = node[:bitstarter_box][:nvm_version]

bash "install forever" do
	user user
	group group
	
	code <<-EOH
       source /home/#{user}/.nvm/nvm.sh
       nvm use #{nvmVersion}
       npm install -g forever
	EOH
end

bash "run bitstarter app" do
	user user
	group group
	cwd "/home/#{user}/#{targetDir}"

	code <<-EOH
     	source /home/#{user}/.nvm/nvm.sh
        nvm use #{nvmVersion}
		nohup forever start web.js
	EOH
end