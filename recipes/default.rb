#
# Cookbook Name:: opam
# Recipe:: default
#
# Copyright (c) 2015 Dave Parfitt, All Rights Reserved.

package "ocaml" do
  action :install
end

package "camlp4" do
  action :install
end

package "m4" do
  action :install
end

# Download the opam binary installer if needed
remote_file "/tmp/opam_installer.sh" do
  source "https://raw.github.com/ocaml/opam/master/shell/opam_installer.sh"
  action :nothing
end

# install opam if it isn't already
execute "Install OPAM" do
  opam_path = node.default['opam-attributes']['path']
  command "sh /tmp/opam_installer.sh #{opam_path}"
  not_if { ::File.exists?("#{opam_path}/opam")}
  notifies :create, "remote_file[/tmp/opam_installer.sh]", :immediately
end

execute "Init OPAM" do
  command "opam init -y"
  user "vagrant"
  not_if { ::File.exists?("/home/vagrant/.opam")}
end

opam_package "oasis" do
  action :install
  user "vagrant"
end
