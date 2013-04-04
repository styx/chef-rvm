#
# Cookbook Name:: rvm
# Recipe:: install

ruby_version = [].tap do |v|
  v << node[:rvm][:ruby][:implementation] if node[:rvm][:ruby][:implementation]
  v << node[:rvm][:ruby][:version] if node[:rvm][:ruby][:version]
  v << node[:rvm][:ruby][:patch_level] if node[:rvm][:ruby][:patch_level]
end * '-'

ruby_patchsets = if node[:rvm][:ruby][:patchsets]
  '--patch ' + node[:rvm][:ruby][:patchsets] * ' '
end

include_recipe 'rvm::default'

bash "installing #{ruby_version}" do
  user 'root'
  code "/usr/local/rvm/bin/rvm install #{ruby_version} #{ruby_patchsets}"
  not_if "/usr/local/rvm/bin/rvm list | grep #{ruby_version}"
end

bash "make #{ruby_version} the default ruby" do
  user 'root'
  code "/usr/local/rvm/bin/rvm --default #{ruby_version}"
  code "/usr/local/rvm/bin/rvm alias create default #{ruby_version}"
  not_if "/usr/local/rvm/bin/rvm list | grep '=> #{ruby_version}'"
  only_if { node[:rvm][:ruby][:default] }
end

# set this for compatibilty with other people's recipes
node.default[:languages][:ruby][:ruby_bin] = find_ruby