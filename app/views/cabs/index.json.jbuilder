json.array!(@cabs) do |cab|
  json.extract! cab, :id, :type, :location_x, :location_y, :status
  json.url cab_url(cab, format: :json)
end
