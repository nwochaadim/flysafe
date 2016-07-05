class FlightsController < ApplicationController
  protect_from_forgery except: [:search, :seats_available]
  
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

  def seats_available
    flight_id = session[:flight_id]
    flight = Flight.where(id: flight_id)
    if flight.any?
      render json: flight.first.to_json(only: [:seats_available])
    else
      render json: {error: true}
    end
  end

  private
  def flight_params
    params.permit(:departs, :arrives, :grade, :adults, :children, :infants, :date)
  end

  def total_passengers
    total_children = flight_params[:children].to_i
    total_adults = flight_params[:adults].to_i
    total_infants = flight_params[:infants].to_i
    store_passengers_info(total_adults, total_children, total_infants)
    total_children + total_adults + total_infants + 1
  end



  def store_passengers_info(total_adults, total_children, total_infants)
    session[:passengers] = {
      total_adults: total_adults,
      total_children: total_children,
      total_infants: total_infants,
      class_level: params[:grade]
    }
  end

  def search_date
    date = flight_params[:date].split("-").map(&:to_i)
    datetime = DateTime.new(date[0],date[1],date[2])
  end
end
