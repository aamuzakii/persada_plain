class Customer
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :phone, type: String
  field :manual_address, type: String
  field :access_type, type: String
  field :is_special_otp_handling, type: Boolean

  has_many :orders
end
