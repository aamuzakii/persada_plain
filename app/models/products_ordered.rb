class ProductsOrdered
  include Mongoid::Document
  include Mongoid::Timestamps
  field :qty, type: Integer
  field :sku, type: String
  field :name, type: String
  field :price, type: Integer
  field :image_url, type: String

  belongs_to :order
end
