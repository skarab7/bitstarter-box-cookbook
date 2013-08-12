require 'minitest/spec'



describe_recipe 'bitstarter-box-cookbook::default' do

	include MiniTest::Chef::Assertions
	include MiniTest::Chef::Context
	include MiniTest::Chef::Resources
	include Chef::Mixin::ShellOut

    describe "packages" do
		it "installed git" do
			package("git").must_be_installed
		end
	
		it "installed emacs24-nox" do
			 package("emacs24-nox").must_be_installed
		end
	end	

	describe "bitstart-app node.js" do

		it "runs bitstart-app" do
			app_port = node[:bitstarter_box][:bitstarter_app][:port]

			assert shell_out("curl -ks -o /dev/null -w '%{http_code}'  http://127.0.0.1:#{app_port}").stdout.include?("200")
		end	

	end
end

