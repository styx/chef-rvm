#
# Cookbook Name:: rvm
# Recipe:: ruby_193

# Install deps as listed by recent revisions of RVM.
%w(build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev autoconf libc6-dev libncurses5-dev automake libtool bison subversion libgdbm-dev libffi-dev).each do |pkg|
  package pkg
end

node.default[:rvm][:ruby][:implementation] = 'ruby'
node.default[:rvm][:ruby][:version] = '1.9.3'
node.default[:rvm][:ruby][:patch_level] = 'p392'
node.default[:rvm][:ruby][:patchsets] = ['railsexpress']
include_recipe 'rvm::install'
