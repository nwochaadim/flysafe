json.array!(@flights) do |flight|
  json.extract! flight, :id, :route, :stops, :plane_name, :seats
  json.url flight_url(flight, format: :json)
end
