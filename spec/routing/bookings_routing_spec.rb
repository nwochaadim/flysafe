require "rails_helper"

RSpec.describe BookingsController, type: :routing do
  describe "routing" do
    it 'routes to #search' do
      expect(get: "/bookings/search").to route_to('bookings#search')
    end

    it 'routes to #book' do
      expect(post: "/bookings/book").to route_to('bookings#book')
    end

    it 'routes to #retrieve' do
      expect(post: "/bookings").to route_to('bookings#retrieve')
    end

    it 'routes to #payment' do
      expect(get: "/bookings/payment").to route_to('bookings#payment')
    end

    it 'routes to #confirm' do
      expect(post: "/bookings/confirm").to route_to('bookings#confirm')
    end

    it 'routes to #validate_payment' do
      expect(get: "bookings/payment/1").to route_to('bookings#validate_payment', flight_id: "1")
    end
  end
end
