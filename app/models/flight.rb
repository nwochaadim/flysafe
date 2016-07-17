class Flight < ActiveRecord::Base
  belongs_to :route
  has_many :bookings

  def self.search(departs, arrives, date, total_passengers)
    sql_query = "date >= ? and seats_available > ?"
    flights = where(sql_query, date, total_passengers)
    flights.uniq(&:date).select do |flight|
      flight.route.departing_airport.name == departs[0..-7] &&
      flight.route.arriving_airport.name == arrives[0..-7]
    end
  end
end
