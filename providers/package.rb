def whyrun_supported?
  true
end

# lots of copy pasta, perhaps I should refactor into a lib?

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
    environment ({'HOME' => homedir, 'USER' => new_resource.user})
    user new_resource.user
    converge_by "opam remove" do
      command "opam remove #{new_resource.name} -y"
    end
  end
end


