def whyrun_supported?
  true
end

action :setup do

  package ["ocaml", "camlp4", "m4"] do
    action :install
  end

  # opam can use git, mercurial, and darcs... do you want
  # all three?
  package new_resource.vcs do
    action :install
  end

  # Download the opam binary installer if needed
  tmp_file =  "#{Chef::Config[:file_cache_path]}/opam_installer.sh"
  #remote_file "/tmp/opam_installer.sh" do
  remote_file tmp_file do
    source "https://raw.github.com/ocaml/opam/master/shell/opam_installer.sh"
    not_if { ::File.exists?(tmp_file)}
  end

  # install opam if it isn't already
  execute "Install OPAM" do
    opam_path = node.default['opam-attributes']['path']
    command "sh #{tmp_file} #{opam_path}"
    not_if { ::File.exists?("#{opam_path}/opam")}
  end

  log "Init OPAM for username #{new_resource.user}"

  execute "Init OPAM" do

    # doesn't support windows yet, I don't have a windows box :-(
    #if platform?("mac_os_x")
    #  homedir = "/Users/#{new_resource.user}"
    #else
    #  homedir = "/home/#{new_resource.user}"
    #end
    puts "USER => #{new_resource.user}"
    homedir = node['etc']['passwd'][new_resource.user]['dir']
    puts "homedir => #{homedir}"
    environment ({'HOME' => homedir, 'USER' => new_resource.user})
    user new_resource.user
    group new_resource.group
    command "opam init -y"
    not_if { ::File.exists?("/home/#{new_resource.user}/.opam")}
    new_resource.updated_by_last_action(true)
  end
end
