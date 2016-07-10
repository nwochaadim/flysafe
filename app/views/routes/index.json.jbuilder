json.array!(@routes) do |route|
  json.extract! route, :id, :departs, :arrives, :date
  json.url route_url(route, format: :json)
end
