user       = node[:bitstarter_box_cookbook][:user]
group      = node[:bitstarter_box_cookbook][:group]
nvmVersion = "v0.10.12"

basicPackages    = ["git", "git-flow", "curl", "rlwrap"]
emacsPackages    = ["emacs24-nox", "emacs24-el", "emacs24-common-non-dfsg"]
dotFilesImported = [".screenrc", ".bash_profile" ".bashrc", ".bashrc_custom", ".emacs.d"]

basicPackages.each do |p|
	package p do
		action :install
	end
end

apt_repository "emacs" do
  uri "https://ppa.launchpad.net/cassou/emacs/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "CEC45805"
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
	CODE <<-EOH
		curl https://raw.github.com/creationix/nvm/master/install.sh | sh
			source /home/#{user}/.nvm/nvm.sh
			nvm install #{nvmVersion}
			nvm use #{nvmVersion}
	EOH
end

bash "install jshint" do
	user user
	group group
	
	CODE <<-EOH
		npm install -g jshint
	EOH
end

bash "install heroku toolbelt" do
	user user
	group group
	CODE <<-EOH
		wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
	EOH
end


bash "backup old dotfiles" do
	cwd "/home/#{user}/"
	CODE <<-EOH
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
   cwd "/home/#{user}/"

   repository "https://github.com/startup-class/dotfiles.git"
   reference "master"
   action :sync
 end


dotFilesImported.each do |file|
	 bash "ln #{file}" do
		 cwd "/home/#{user}/"
	  	EOH <<-EOH
			ln -sb  dotfiles/#{file}
	 	EOH
	 end
end
