require 'rails_helper'

RSpec.describe Route, type: :model do
  let!(:route) { Route.create }
  subject { route }

  describe 'Instance Methods' do
    it { is_expected.to respond_to(:departing_airport) }
    it { is_expected.to respond_to(:arriving_airport) }
    it { is_expected.to respond_to(:flight) }
  end
end
