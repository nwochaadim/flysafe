class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  attr_accessor :token

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.all
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new

  end

  def confirm
    $booking_params = booking_params
    respond_to do |format|
      format.js
    end
  end

  def book
    $selected_flight = Flight.find(params[:selected_flight])
    respond_to do |format|
      format.js
    end
  end

  def payment
    paypal_options = {
      no_shipping: true, # if you want to disable shipping information
      allow_note: false, # if you want to disable notes
      pay_on_paypal: true # if you don't plan on showing your own confirmation step
    }

    request = Paypal::Express::Request.new(
      :username   => "nwocha.adim-facilitator_api1.gmail.com",
      :password   => "65KMEBVFE3V5MQVF",
      :signature  => "AiPC9BjkCyDFQXbSkoZcgqH3hpacAWHLrfN1pZw2YLyitsE1A89vwHDf"
    )
    payment_request = Paypal::Payment::Request.new(
      :description   => "Book Your Flight while you are alive",
      :quantity      => 1,
      :amount        => $total_cost,
      :custom_fields => {
        CARTBORDERCOLOR: "C00000",
        LOGOIMG: "http://clipartbest.com//cliparts/McL/oaR/McLoaRqca.svg"
      }
    )
    response = request.setup(
      payment_request,
      validate_payment_url($selected_flight),
      contact_url,
      paypal_options  # Optional
    )
    redirect_to response.redirect_uri
  end


  def validate_payment
    binding.pry
    flight = Flight.find(params[:flight_id])
    create_booking(flight)
  end

  def create_booking(flight)
    if current_user.nil?
      booking = flight.bookings.create(reference_number: generate_token)
    else
      booking = current_user.bookings.create(reference_number: generate_token)
      booking.flight = flight
    end
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params)

    respond_to do |format|
      if @booking.save
        format.html { redirect_to @booking, notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def generate_token
      loop do
        @token = SecureRandom::hex(6);
        bookings = Booking.where(reference_number: @token)
        break if bookings.empty?
      end
      @token
    end

    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      passenger_fields = ["gender", "first-name", "last-name"]
      params.permit(:first_name, :last_name, :email, adult: passenger_fields, child: passenger_fields, infant: passenger_fields)
    end
end
