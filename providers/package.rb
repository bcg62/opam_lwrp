def whyrun_supported?
  true
end

# lots of copy pasta, perhaps I should refactor into a lib?

action :install do
  execute "opam install" do
    if platform?("mac_os_x")
      homedir = "/Users/#{new_resource.user}}"
    else
      homedir = "/home/#{new_resource.user}"
    end
    homedir = "/root" if new_resource.user == 'root'
    # doesn't support windows yet, I don't have a windows box :-(
    environment ({'HOME' => homedir, 'USER' => new_resource.user})
    user new_resource.user
    converge_by "opam install #{new_resource.name}" do
      command "opam install #{new_resource.name} -y"
    end
  end
end


action :update do
  execute "opam update" do
    # doesn't support windows yet, I don't have a windows box :-(
    if platform?("mac_os_x")
      homedir = "/Users/#{new_resource.user}}"
    else
      homedir = "/home/#{new_resource.user}"
    end
    homedir = "/root" if new_resource.user == 'root'
    environment ({'HOME' => homedir, 'USER' => new_resource.user})
    user new_resource.user
    converge_by "opam update" do
      command "opam update"
    end
  end
end

action :upgrade do
  execute "opam upgrade" do
    # doesn't support windows yet, I don't have a windows box :-(
    if platform?("mac_os_x")
      homedir = "/Users/#{new_resource.user}}"
    else
      homedir = "/home/#{new_resource.user}"
    end
    homedir = "/root" if new_resource.user == 'root'
    environment ({'HOME' => homedir, 'USER' => new_resource.user})
    user new_resource.user
    converge_by "opam upgrade" do
      command "opam upgrade"
    end
  end
end

action :remove do
  execute "opam remove" do
    # doesn't support windows yet, I don't have a windows box :-(
    if platform?("mac_os_x")
      homedir = "/Users/#{new_resource.user}}"
    else
      homedir = "/home/#{new_resource.user}"
    end
    homedir = "/root" if new_resource.user == 'root'
    environment ({'HOME' => homedir, 'USER' => new_resource.user})
    user new_resource.user
    converge_by "opam remove" do
      command "opam remove #{new_resource.name} -y"
    end
  end
end

action :setup do
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

  log "Init OPAM for username #{params[:user]}"

  execute "Init OPAM" do

    # doesn't support windows yet, I don't have a windows box :-(
    if platform?("mac_os_x")
      homedir = "/Users/#{params[:user]}"
    else
      homedir = "/home/#{params[:user]}"
    end
    homedir = "/root" if new_resource.user == 'root'

    environment ({'HOME' => homedir, 'USER' => params[:user]})
    user params[:user]
    group params[:group]
    command "opam init -y"
    not_if { ::File.exists?("/home/#{params[:user]}/.opam")}
    new_resource.updated_by_last_action(true)
  end
end
