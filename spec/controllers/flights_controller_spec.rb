require "rails_helper"

RSpec.describe FlightsController, type: :controller do
  before(:all) { @flight = create(:flight, :departing, :arriving) }
  let(:valid_attributes) do
    {
      departs: "Abuja Intenational Airport (ABV)",
      arrives: "Benin Airport (BNI)",
      grade: "Economy",
      adults: "1",
      children: "1",
      infants: "1",
      date: "2016-06-27"
    }
  end

  describe '#search' do
    it "renders search template" do
      valid_attributes[:format] = :js
      get :search, valid_attributes
      expect(response).to render_template(:search)
    end
  end

  describe '#seats_available' do
    context "when flight is valid" do
      it "renders the number of seats available as json" do
        session[:flight_id] = @flight.id
        get :seats_available
        seats = { seats_available: @flight.seats_available }.to_json
        expect(response.body).to eq(seats)
      end
    end

    context "when flight is invalid" do
      it "renders an error status as json if flight id is invalid" do
        get :seats_available
        error = { error: true }.to_json
        expect(response.body).to eq(error)
      end
    end
  end
end
