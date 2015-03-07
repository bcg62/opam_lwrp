actions :install, :remove, :update, :upgrade
default_action :install

attribute :name, :kind_of => String, :name_attribute => true
attribute :user, :kind_of => String, :required => true
