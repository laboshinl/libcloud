actions :wait

attribute :address, :name_attribute => true
attribute :port, :required => true
attribute :timeout, :default => 300
attribute :delay, :default => 2

def initialize(*args)
  super
  @action = :wait
end

