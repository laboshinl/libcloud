actions :append

attribute :file, :name_attribute => true
attribute :line, :kind_of => [String, Array], :required => true

def initialize(*args)
    super
    @action = :append
end
