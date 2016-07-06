require 'rails_helper'

RSpec.describe UsersController, type: :routing do
  describe 'routing' do
    it 'routes to #new' do
      expect(get: '/signup').to route_to('users#new')
    end

    it 'routes to #past_bookings' do
      expect(get: '/users/1/bookings').to route_to('users#past_bookings', user_id: '1')
    end
  end
end
