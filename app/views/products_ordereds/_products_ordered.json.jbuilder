json.extract! products_ordered, :id, :qty_ordered, :created_at, :updated_at
json.url products_ordered_url(products_ordered, format: :json)
