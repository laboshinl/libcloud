actions [:create, :add] 

attribute :key_name, :default => "id_rsa"
attribute :data_bag, :required => true
attribute :keypair, :name_attribute => true
attribute :user, :default => "root" 

def initialize(*args)
    super
    @action = :create
end
