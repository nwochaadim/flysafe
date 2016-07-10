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
    session[:booking_params] = booking_params
    @booking_params = booking_params
    respond_to do |format|
      format.js
    end
  end

  def book
    session[:flight_id] = params[:selected_flight]
    respond_to do |format|
      format.js
    end
  end

  def payment
    selected_flight = Flight.find(session[:flight_id])
    create_booking(selected_flight)

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
      validate_payment_url(selected_flight, @booking),
      contact_url,
      paypal_options  # Optional
    )
    redirect_to response.redirect_uri
  end

  def validate_payment
    @booking = Booking.find(params[:booking_id])
  end

  def create_booking(flight)
    retrieved_booking_params = session[:booking_params]
    if current_user.nil?
      user = UnregisteredUser.create(
        first_name: retrieved_booking_params[:first_name],
        last_name: retrieved_booking_params[:last_name],
        email: retrieved_booking_params[:email]
        )
      @booking = user.bookings.create(reference_number: generate_token)
      @booking.update(flight: flight)
      seats_available = flight.seats_available - session[:total_passengers]
      flight.update(seats_available: seats_available)
      addPassengers(@booking, retrieved_booking_params)
    else
      @booking = current_user.bookings.create(reference_number: generate_token)
      @booking.update(flight: flight)
      addPassengers(@booking, retrieved_booking_params)
    end 
  end

  def addPassengers(booking, booking_param)
    if booking_param["adult"]
      createAdultPassengers(booking, booking_param["adult"])
    elsif booking_param["child"]
      createChildPassengers(booking, booking_param["child"])
    elsif booking_param["infant"]
      createInfantPassengers(booking, booking_param["infant"])
    end
  end

  def createAdultPassengers(booking, adults)
    adults.each do |adult|
      booking.passengers.create(
        first_name: adult["first-name"], 
        last_name: adult["last-name"],
        age_grade: "Adult"
        )
    end
  end

  def createChildPassengers(booking, children)
    children.each do |child|
      booking.passengers.create(
        first_name: child["first-name"], 
        last_name: child["last-name"],
        age_grade: "Child"
        )
    end
  end

  def createInfantPassengers(booking, infants)
    infants.each do |infant|
      booking.passengers.create(
        first_name: infant["first-name"], 
        last_name: infant["last-name"],
        age_grade: "Infant"
        )
    end
  end

  # GET /bookings/1/edit
  def edit
  end

  def search
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
