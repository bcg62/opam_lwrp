#
# Cookbook Name:: opam
# Recipe:: default
#
# Copyright (c) 2015 Dave Parfitt, All Rights Reserved.


# generally frowned upon, but... nothing else works?
if platform?("ubuntu")
    execute "apt-get update" do
      command "apt-get update"
      ignore_failure true
    end
end


user "dparfitt" do
  action :create
  home "/home/dparfitt"
  shell "/bin/bash"
  supports :manage_home=>true
end


opam_setup do
  user "dparfitt"
  group "dparfitt"
  vcs  ["git", "mercurial"]
end


opam_package "oasis" do
  action :install
  user "dparfitt"
end
