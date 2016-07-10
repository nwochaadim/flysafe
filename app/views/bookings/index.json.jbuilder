json.array!(@bookings) do |booking|
  json.extract! booking, :id, :reference_number
  json.url booking_url(booking, format: :json)
end
