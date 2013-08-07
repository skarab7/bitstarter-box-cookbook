#
# Cookbook Name:: bitstarter-box-cookbook
# Recipe:: default
#
# Copyright (C) 2013 skarab7
# 
# All rights reserved - Do Not Redistribute
#

execute "apt-get-update" do
  command "apt-get update"
end

include_recipe "bitstarter-box-cookbook::basic_setup"  