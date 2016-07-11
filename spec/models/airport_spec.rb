require 'rails_helper'

RSpec.describe Airport, type: :model do
  before(:each) { @airport = create(:airport) }

  describe 'Initializing Airport' do
    let(:airport1) { build(:airport, name: nil) }
    let(:airport2) { build(:airport, country: nil) }
    let(:airport3) { build(:airport, state: nil) }
    let(:airport4) { build(:airport, airport_code: nil) }

    it 'validates presence of name' do
      expect(airport1).to be_invalid
    end

    it 'validates presence of country' do
      expect(airport2).to be_invalid
    end

    it 'validates presence of state' do
      expect(airport3).to be_invalid
    end

    it 'validates presence of airport_code' do
      expect(airport4).to be_invalid
    end

    it 'overrides attributes method' do
      expect(@airport.attributes).to eql(name: @airport.name,
                                         country: @airport.country,
                                         state: @airport.state,
                                         airport_code: @airport.airport_code)
    end
  end

  describe 'Instance Methods' do
    subject { @airport }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:country) }
    it { is_expected.to respond_to(:state) }
    it { is_expected.to respond_to(:airport_code) }
  end
end
