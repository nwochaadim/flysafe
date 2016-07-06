require 'rails_helper'

RSpec.describe Passenger, type: :model do
  let!(:passenger) { create(:adult_passenger) }
  subject { passenger }

  describe 'Initializing Passenger' do
    let(:passenger1) { Passenger.create(last_name: 'George') }
    let(:passenger2) { Passenger.create(first_name: 'James') }
    it 'validates presence of first_name' do
      expect(passenger1).to be_invalid
    end

    it 'validates presence of last_name' do
      expect(passenger2).to be_invalid
    end
  end

  describe 'Instance Methods' do
    it { is_expected.to respond_to(:first_name) }
    it { is_expected.to respond_to(:last_name) }
    it { is_expected.to respond_to(:age_grade) }
  end

  describe 'Active Model Relation' do
    it { is_expected.to respond_to(:booking) }
  end
end
