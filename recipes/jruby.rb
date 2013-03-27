#
# Cookbook Name: rvm
# Recipe: jruby

# Install deps as listed by recent revisions of RVM.
%w(curl g++ openjdk-7-jre-headless ant openjdk-7-jdk).each do |pkg|
  package pkg
end

node.default[:rvm][:ruby][:implementation] = 'jruby'
node.default[:rvm][:ruby][:version] = '1.7.2'
include_recipe 'rvm::install'
