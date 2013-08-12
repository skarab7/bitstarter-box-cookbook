site :opscode

metadata

cookbook "apt", "2.0.0"
cookbook "nginx", ""

group :integration do
	cookbook "minitest-handler"
	cookbook "bitstarter-box-test", path: "test/cookbooks/bitstarter-box-test"
end
