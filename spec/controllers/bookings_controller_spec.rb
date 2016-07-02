require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  before(:each){ @booking = create(:booking) }

  let(:valid_attributes) {
    { first_name: Faker::Name.name,
      last_name: Faker::Name.name,
      format: "js",
      email: Faker::Internet.email,
      adult: [{gender: "1", "first-name": "John", "last-name": "Travolta"}],
      child: [{"first-name": "Mercy", "last-name": "Johnson"}],
      infant: [{"first-name": "Michelle", "last-name": "Obama"}] 
    }
  }

  describe "POST #confirm" do
    it "renders booking confirmation page having all details" do
      post :confirm, valid_attributes
      expect(response).to render_template(:confirm)
    end
  end

  describe "POST #book" do
    it "renders booking page" do
      params = { selected_flight: @booking.flight.id, format: "js" }
      session[:passengers] = { total_adults: 2, total_children: 1, total_infants: 0 }
      post :book, params
      expect(response).to render_template(:book)
    end
  end

  describe "POST #book" do
    xit "renders booking page" do
      params = { selected_flight: @booking.flight.id, format: "js" }
      post :book, params
      expect(response).to render_template(:book)
    end
  end

  describe "GET #validate_payment" do
    it "validates payment token and updates booking records" do
      session[:booking_params] = valid_attributes
      session[:token] = SecureRandom::hex(6)
      session[:flight_id] = @booking.flight.id
      session[:passengers] = {}
      session[:passengers]["class_level"] = "Economy"
      params = { token: session[:token], flight_id: @booking.flight.id }
      get :validate_payment, params
      expect(response).to render_template(:validate_payment)
    end
  end

  describe "GET #retrieve" do
    it "returns booking reservation" do
      params = { reference_number: @booking.reference_number, format: :js }
      get :retrieve, params
      expect(response).to render_template(:retrieve)
    end
  end

  describe "GET #search" do
    it "renders booking search page" do
      get :search
      expect(response).to render_template(:search)
    end
  end

end
