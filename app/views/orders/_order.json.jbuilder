json.extract! order, :id, :additional_info, :order_note, :delivery_note, :delivery_date, :order_number, :delivery_cost, :subtotal, :total, :created_at, :updated_at
json.url order_url(order, format: :json)
