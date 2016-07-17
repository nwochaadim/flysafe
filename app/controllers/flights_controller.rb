class FlightsController < ApplicationController
  protect_from_forgery except: [:search, :seats_available]

  def search
    @retrieved_flights = Flight.search(
      params[:departs],
      params[:arrives],
      search_date,
      total_passengers
    )
    render format: :js
  end

  def seats_available
    id = session[:flight_id]
    flight = Flight.find_by(id: id)
    if flight
      render json: flight.to_json(only: [:seats_available])
    else
      render json: { error: true }
    end
  end

  private

  def total_passengers
    total_children = params[:children].to_i
    total_adults = params[:adults].to_i
    total_infants = params[:infants].to_i
    store_passengers_info(total_adults, total_children, total_infants)
    total_children + total_adults + total_infants
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
    date = params[:date].split("-").map(&:to_i)
    datetime = DateTime.new(date[0], date[1], date[2])
  end
end
