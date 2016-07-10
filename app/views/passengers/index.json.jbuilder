json.array!(@passengers) do |passenger|
  json.extract! passenger, :id, :name, :sex, :age, :type
  json.url passenger_url(passenger, format: :json)
end
