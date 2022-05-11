class Customer
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :phone, type: String
end
