user       = node[:bitstarter_box_cookbook][:user]
group      = node[:bitstarter_box_cookbook][:group]
nvmVersion = "v0.10.12"

basicPackages    = ["git", "git-flow", "curl", "rlwrap"]
emacsPackages    = ["emacs24-nox", "emacs24-el", "emacs24-common-non-dfsg"]
dotFilesImported = [".screenrc", ".bash_profile", ".bashrc", ".bashrc_custom", ".emacs.d"]

basicPackages.each do |p|
	package p do
		action :install
	end
end

apt_repository "emacs" do
  uri "http://ppa.launchpad.net/cassou/emacs/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "CEC45805"
end

execute "apt-get-update" do
  command "apt-get update"
end

emacsPackages.each do |d|
	package d do
		action :install
	end
end

bash "install nvm" do
	user user
	group group
	cwd "/home/#{user}/"
	code <<-EOH
		curl https://raw.github.com/creationix/nvm/master/install.sh | sh
		source /home/#{user}/.nvm/nvm.sh
		nvm install #{nvmVersion[1..-1]}
		nvm use #{nvmVersion}
	EOH
end

bash "install jshint" do
	user user
	group group
	
	code <<-EOH
        source /home/#{user}/.nvm/nvm.sh
        nvm use #{nvmVersion}
		npm install -g jshint
	EOH
end

bash "install heroku toolbelt" do
	user user
	group group
	code <<-EOH
		wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | tr 'sudo -k' '' | tr 'sudo' ''  | sh
	EOH
end


bash "backup old dotfiles" do
	cwd "/home/#{user}/"
	user  user
	group group
	
	code <<-EOH
		if [ -d ./dotfiles/ ]; then
			mv dotfiles dotfiles.old
		fi
		
		if [ -d .emacs.d/ ]; then
			mv .emacs.d .emacs.d~
		fi
	EOH
end

git "/home/#{user}/dotfiles" do
   user  user
   group group
   
   repository "https://github.com/startup-class/dotfiles.git"
   reference "master"
   action :sync
 end


dotFilesImported.each do |file|
	 bash "ln #{file}" do
	 	user  user
		group group

		cwd "/home/#{user}/"
	  	code <<-EOH
			ln -sb  dotfiles/#{file}
	 	EOH
	 end
end
