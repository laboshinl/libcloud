actions :run

attribute :server, :required => true
attribute :password
attribute :user, :default => "root"
attribute :port, :default => 22
attribute :command, :kind_of => [String, Array], :name_attribute => true

def initialize(*args)
  super
  @action = :run
end

