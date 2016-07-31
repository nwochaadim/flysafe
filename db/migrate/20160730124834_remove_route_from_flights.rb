class RemoveRouteFromFlights < ActiveRecord::Migration
  def change
    remove_reference :flights, :route, index: true, foreign_key: true
  end
end
