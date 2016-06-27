class FlightsController < ApplicationController
  protect_from_forgery except: :search
  
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

  private
    def flight_params
      params.permit(:departs, :arrives, :grade, :adults, :children, :infants, :date)
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
end
