class Flight < ActiveRecord::Base
  has_many :bookings
  belongs_to :from_airport, class_name: "Airport"
  belongs_to :to_airport, class_name: "Airport"

  def self.search(departs, arrives, date, total_passengers)
    sql_query = "date >= ? and seats_available > ?"
    flights = where(sql_query, date, total_passengers)
    flights.uniq(&:date).select do |flight|
      flight.from_airport.name == departs[0..-7] &&
        flight.to_airport.name == arrives[0..-7]
    end
  end
end
