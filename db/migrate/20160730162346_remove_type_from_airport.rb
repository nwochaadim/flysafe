class RemoveTypeFromAirport < ActiveRecord::Migration
  def change
    remove_column :airports, :type, :string
  end
end
