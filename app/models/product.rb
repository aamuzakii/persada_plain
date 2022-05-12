class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :image_url, type: String
  field :description, type: String
  field :price, type: Integer
  field :stock_type, type: String

  belongs_to :category
end
