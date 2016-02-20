json.array!(@customers) do |customer|
  json.extract! customer, :id, :name, :location_x, :location_y, :destination_x, :destination_y, :request_type
  json.url customer_url(customer, format: :json)
end
