class Otp
  include Mongoid::Document
  include Mongoid::Timestamps
  field :otp_code, type: String
  field :phone_number, type: String
end
