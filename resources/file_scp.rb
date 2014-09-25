actions [:upload, :download]

attribute :server, :required => true
attribute :password
attribute :user, :default => "root"
attribute :port, :default => 22
attribute :local_path, :name_attribute => true
attribute :remote_path, :required => true

def initialize(*args)
  super
  @action = :download
end
