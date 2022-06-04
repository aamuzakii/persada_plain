class Customer
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :email, type: String
  field :phone, type: String
  field :manual_address, type: String
  field :access_type, type: String
  field :is_special_otp_handling, type: Boolean
  field :pofile_photo, type: String
  field :google_id, type: Boolean

  has_many :orders
end
