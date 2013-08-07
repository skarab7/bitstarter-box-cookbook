#
# Cookbook Name:: bitstarter-box
# Recipe:: default
#
# Copyright (C) 2013 skarab7
# 
# All rights reserved - Do Not Redistribute
#

execute "apt-get-update" do
  command "apt-get update"
end

include_recipe "bitstarter-box::basic_setup"  

include_recipe "bitstarter-box::retrieve_bitstarter_app"