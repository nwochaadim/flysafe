class AddFromAirportToFlights < ActiveRecord::Migration
  def change
    add_reference :flights, :from_airport, index: true, foreign_key: true
  end
end
