class DropTableRoutes < ActiveRecord::Migration
  def change
    drop_table :routes
  end
end
