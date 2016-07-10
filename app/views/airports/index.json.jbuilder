json.array!(@airports) do |airport|
  json.extract! airport, :id, :name, :location
  json.url airport_url(airport, format: :json)
end
