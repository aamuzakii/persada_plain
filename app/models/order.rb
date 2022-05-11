class Order
  include Mongoid::Document
  include Mongoid::Timestamps
  field :additional_info, type: String
  field :order_note, type: String
  field :delivery_note, type: String
  field :delivery_date, type: Date
  field :order_number, type: String
  field :delivery_cost, type: Integer
  field :subtotal, type: Integer
  field :total, type: Integer
end
