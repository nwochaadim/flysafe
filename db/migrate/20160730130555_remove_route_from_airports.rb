class RemoveRouteFromAirports < ActiveRecord::Migration
  def change
    remove_reference :airports, :route, index: true, foreign_key: true
  end
end
