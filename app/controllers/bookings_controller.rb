class BookingsController < ApplicationController  
  attr_accessor :token

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
    request = Paypal::Express::Request.new(paypal_request_params)
    payment_request = Paypal::Payment::Request.new(payment_request_params)
    response = request_paypal_payment(request, payment_request, selected_flight)
    session[:token] = response.token
    redirect_to response.redirect_uri
  end

  def validate_payment
    if params[:token] == session[:token]
      selected_flight = Flight.find(session[:flight_id])
      create_booking(selected_flight)
    end
  end

  def retrieve
    reference_number = params[:reference_number]
    @booking = Booking.where(reference_number: reference_number).first
    respond_to do |format|
      format.js
    end
  end

  def create_booking(flight)
    retrieved_booking_params = session[:booking_params]
    user = !current_user.nil? || create_unregistered_user(retrieved_booking_params)
    @booking = user.bookings.create(reference_number: generate_token, class_level: "Economy")
    @booking.addPassengers(retrieved_booking_params)
    @booking.allocate_flight(flight)
  end

  def create_unregistered_user(retrieved_booking_params)
    UnregisteredUser.create(
      first_name: retrieved_booking_params[:first_name],
      last_name: retrieved_booking_params[:last_name],
      email: retrieved_booking_params[:email]
    )
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

    def paypal_options 
      {
        no_shipping: true, 
        allow_note: false,
        pay_on_paypal: true
      }
    end

  def paypal_request_params
    {
      username: "nwocha.adim-facilitator_api1.gmail.com",
      password: "65KMEBVFE3V5MQVF",
      signature: "AiPC9BjkCyDFQXbSkoZcgqH3hpacAWHLrfN1pZw2YLyitsE1A89vwHDf"
    }
  end

  def payment_request_params
    {
      description: "Book Your Flight while you are alive",
      quantity: 1,
      amount: $total_cost,
      custom_fields: {
        CARTBORDERCOLOR: "C00000",
        LOGOIMG: "http://clipartbest.com//cliparts/McL/oaR/McLoaRqca.svg"
      }
    }
  end

  def request_paypal_payment(request, payment_request, selected_flight)
    request.setup(
      payment_request,
      validate_payment_url(selected_flight),
      contact_url,
      paypal_options
    ) 
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def booking_params
    passenger_fields = ["gender", "first-name", "last-name"]
    params.permit(:first_name, :last_name, :email, adult: passenger_fields, child: passenger_fields, infant: passenger_fields)
  end
end
