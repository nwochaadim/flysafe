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
    flight = Flight.find_by(id: session[:flight_id])

    if flight
      render json: flight.to_json(only: [:seats_available])
    else
      render json: { error: true }
    end
  end

  private

  def total_passengers
    data = { 
             total_children: params[:children],
             total_adults: params[:adults],
             total_infants: params[:infants] 
           }
    store_passengers_info
    data.values.map(&:to_i).inject(0) { |sum, x| sum + x }
  end

  def store_passengers_info
    session[:passengers] = { class_level: params[:grade] }
  end

  def search_date
    Time.zone.parse(params[:date])
  end
end
