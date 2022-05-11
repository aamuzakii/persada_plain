class ProductsOrdered
  include Mongoid::Document
  include Mongoid::Timestamps
  field :qty_ordered, type: Integer
end
