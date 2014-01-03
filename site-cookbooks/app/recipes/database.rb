#
# Cookbook Name:: app
# Recipe:: database
#
# Copyright 2013, Rémi GATTAZ
#

# install mysql
include_recipe "mysql"
include_recipe "mysql::server"