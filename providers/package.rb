def whyrun_supported?
  true
end

action :install do
  execute "opam install" do
    # doesn't support windows yet, I don't have a windows box :-(
    if platform?("mac_os_x")
      homedir = "/Users/#{new_resource.user}}"
    else
      homedir = "/home/#{new_resource.user}"
    end
    environment ({'HOME' => homedir, 'USER' => new_resource.user})
    user new_resource.user
    converge_by "OPAM install #{new_resource.name}" do
      command "opam install #{new_resource.name} -y"
    end
  end
end

