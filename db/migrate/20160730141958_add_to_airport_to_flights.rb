class AddToAirportToFlights < ActiveRecord::Migration
  def change
    add_reference :flights, :to_airport, index: true, foreign_key: true
  end
end
