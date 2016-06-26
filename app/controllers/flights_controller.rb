class FlightsController < ApplicationController
  protect_from_forgery except: :search
  #before_action :set_flight, only: [:show, :edit, :update, :destroy]

  # GET /flights
  # GET /flights.json
  def index
    @flights = Flight.all
  end

  # GET /flights/1
  # GET /flights/1.json
  def show
  end

  # GET /flights/new
  def new
    @flight = Flight.new
  end

  # GET /flights/1/edit
  def edit
  end

  def search
    sql_query = "date >= ? and seats_available > ?"
    flights = Flight.where(sql_query, search_date, total_passengers)
    @retrieved_flights = flights.uniq(&:date).select do |flight|
      flight.route.departing_airport.name == flight_params[:departs][0..-7] &&
      flight.route.arriving_airport.name == flight_params[:arrives][0..-7]
    end
    respond_to do |format|
      format.js
    end
  end

  def total_passengers
    $no_of_children = flight_params[:children].to_i
    $no_of_adults = flight_params[:adults].to_i
    $no_of_infants = flight_params[:infants].to_i
    session[:total_passengers] = $no_of_children + $no_of_adults + 1
  end

  def search_date
    date = flight_params[:date].split("-").map(&:to_i)
    datetime = DateTime.new(date[0],date[1],date[2])
  end
  # POST /flights
  # POST /flights.json
  def create
    @flight = Flight.new(flight_params)

    respond_to do |format|
      if @flight.save
        format.html { redirect_to @flight, notice: 'Flight was successfully created.' }
        format.json { render :show, status: :created, location: @flight }
      else
        format.html { render :new }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flights/1
  # PATCH/PUT /flights/1.json
  def update
    respond_to do |format|
      if @flight.update(flight_params)
        format.html { redirect_to @flight, notice: 'Flight was successfully updated.' }
        format.json { render :show, status: :ok, location: @flight }
      else
        format.html { render :edit }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flights/1
  # DELETE /flights/1.json
  def destroy
    @flight.destroy
    respond_to do |format|
      format.html { redirect_to flights_url, notice: 'Flight was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flight
      @flight = Flight.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flight_params
      params.permit(:departs, :arrives, :grade, :adults, :children, :infants, :date)
    end
end
