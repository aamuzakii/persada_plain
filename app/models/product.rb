class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :image_url, type: String
  field :description, type: String
  field :price, type: Integer
  field :stock_type, type: String
  field :is_toggle_show, type: Boolean

  belongs_to :category, optional: true
end
