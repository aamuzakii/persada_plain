class Order
  include Mongoid::Document
  include Mongoid::Timestamps
  field :additional_info, type: String
  field :order_note, type: String
  field :delivery_note, type: String
  field :delivery_date, type: Date
  field :order_number, type: String
  field :status, type: String
  field :delivery_cost, type: Integer
  field :subtotal, type: Integer
  field :total, type: Integer

  # https://www.mongodb.com/community/forums/t/how-would-you-model-this-database/12184

  has_many :products_ordereds
  belongs_to :customer
end
