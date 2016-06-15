class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.integer :stops
      t.string :plane_name
      t.integer :seats
      t.string :class_level

      t.timestamps null: false
    end
  end
end
