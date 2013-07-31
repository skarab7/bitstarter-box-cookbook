require 'minitest/spec'

include MiniTest::Chef::Assertions
include MiniTest::Chef::Context
include MiniTest::Chef::Resources

include Chef::Mixin::ShellOut

describe_recipe 'bitstarter-box-cookbook::default' do
	it "installed git" do
		 package("git").must_be_installed
	end
	
	it "installed emacs24-nox" do
		 package("emacs24-nox").must_be_installed
	end
end

