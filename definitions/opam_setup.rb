
define :opam_setup,
          :user => "vagrant",
          :group => "vagrant",
          :vcs => ["git", "mercurial", "darcs"] do


  package ["ocaml", "camlp4", "m4"] do
    action :install
  end

  # opam can use git, mercurial, and darcs... do you want
  # all three?
  package params[:vcs] do
    action :install
  end

  # Download the opam binary installer if needed
  remote_file "/tmp/opam_installer.sh" do
    source "https://raw.github.com/ocaml/opam/master/shell/opam_installer.sh"
    not_if { ::File.exists?("/tmp/opam_installer.sh")}
  end

  # install opam if it isn't already
  execute "Install OPAM" do
    opam_path = node.default['opam-attributes']['path']
    command "sh /tmp/opam_installer.sh #{opam_path}"
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

    environment ({'HOME' => homedir, 'USER' => params[:user]})
    user params[:user]
    group params[:group]
    command "opam init -y"
    not_if { ::File.exists?("/home/#{params[:user]}/.opam")}
  end
end

