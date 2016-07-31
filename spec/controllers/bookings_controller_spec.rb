require "rails_helper"

RSpec.describe BookingsController, type: :controller do
  before { @booking = create(:booking) }

  let(:valid_attributes) do
    {
      format: :js,
      adult: [{ first_name: "John", last_name: "Doe", email: "a@gmail.com" }],
      child: [{ first_name: "Mercy", last_name: "Johnson" }],
      infant: [{ first_name: "Michelle", last_name: "Obama" }]
    }
  end

  describe "#confirm" do
    it "renders booking confirmation page having all details" do
      post :confirm, valid_attributes
      expect(response).to render_template(:confirm)
    end
  end

  describe "#book" do
    it "renders booking page" do
      params = { selected_flight: @booking.flight.id, format: "js" }
      post :book, params
      expect(response).to render_template(:book)
    end
  end

  describe "#payment" do
    it "redirects to paypal" do
      session[:flight_id] = @booking.flight.id
      paypal_construct = Struct.new(:token, :redirect_uri)
      paypal_response = paypal_construct.new("TOKEN", "http://paypal.com")

      allow_any_instance_of(PaymentService).to receive(:make_payment).
        and_return(paypal_response)
      get :payment

      expect(response).to redirect_to(paypal_response.redirect_uri)
    end
  end

  describe "#validate_payment" do
    before(:each) do
      session[:booking_params] = valid_attributes
      session[:token] = SecureRandom.hex(6)
      session[:flight_id] = @booking.flight.id
      session[:passengers] = { class_level: "Economy" }.stringify_keys
    end

    context "when payment is valid" do
      it "creates booking and renders booking template" do
        params = { token: session[:token], flight_id: @booking.flight.id }
        allow_any_instance_of(ActionMailer::MessageDelivery).
          to receive(:deliver_now).and_return(true)
        get :validate_payment, params
        expect(response).to render_template(:validate_payment)
      end
    end

    context "when payment is invalid" do
      it "notifies user of invalid payment" do
        params = { token: SecureRandom.hex(6), flight_id: @booking.flight.id }
        get :validate_payment, params
        expect(flash[:notice]).to eql("Error, Your payment is invalid.")
      end
    end
  end

  describe "#retrieve" do
    it "returns booking reservation" do
      params = { reference_number: @booking.reference_number, format: :js }
      get :retrieve, params
      expect(response).to render_template(:retrieve)
    end
  end

  describe "#search" do
    it "renders booking search page" do
      get :search
      expect(response).to render_template(:search)
    end
  end

  describe "#update" do
    it "updates the booking reservation" do
      attributes = valid_attributes.merge(
        reference_number: @booking.reference_number
      )
      put :update, attributes
      expect(@booking.passengers.count).to eql(3)
    end
  end

  describe "#destroy" do
    it "renders booking search page" do
      delete :destroy, reference_number: @booking.reference_number
      expect(Booking.all).to_not include(@booking)
    end
  end
end
