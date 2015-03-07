def whyrun_supported?
  true
end

action :install do
  puts "OPAM installing something"
  execute "opam install" do
    user new_resource.user
    converge_by "OPAM install #{new_resource.name}" do
      command "opam install #{new_resource.name} -y"
    end
  end
end

