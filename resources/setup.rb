actions :setup
default_action :setup

attribute :name, :kind_of => String, :name_attribute => true
attribute :user, :kind_of => String, :required => true
attribute :group, :kind_of => String, :default => nil
attribute :vcs, :kind_of => Array, :default => ["git", "mercurial", "darcs"]
