class Customer
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :phone, type: String
  field :manual_address, type: String

  has_many :orders
end
