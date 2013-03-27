#
# Cookbook Name:: rvm
# Recipe:: default

# Make sure that the package list is up to date on Ubuntu/Debian.
include_recipe 'apt' if [ 'debian', 'ubuntu' ].include? node[:platform]

# Make sure we have all we need to compile ruby implementations:
package 'curl'
package 'git-core'
include_recipe 'build-essential'

%w(libreadline-dev zlib1g-dev libssl-dev libxml2-dev libxslt1-dev libtool).each do |pkg|
  package pkg
end

bash 'Installing system-wide RVM' do
  user 'root'
  code "curl -L get.rvm.io | sudo bash -s #{node[:rvm][:version]}; echo"
  not_if 'test -e /usr/local/rvm/bin/rvm'
end

bash "Up to RVM head" do
  user "root"
  code "/usr/local/rvm/bin/rvm get head ; /usr/local/rvm/bin/rvm reload"
  only_if { node[:rvm][:version] == :head }
  only_if { node[:rvm][:track_updates] }
end

bash "upgrading RVM stable" do
  user "root"
  code "/usr/local/rvm/bin/rvm update ; /usr/local/rvm/bin/rvm reload"
  only_if { node[:rvm][:track_updates] }
end

cookbook_file "/usr/local/rvm/bin/rvm-gem.sh" do
  owner "root"
  group "root"
  mode 0755
end

# set this for compatibilty with other people's recipes
node.default[:languages][:ruby][:ruby_bin] = find_ruby

