class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.integer :stops
      t.string :plane_name
      t.integer :seats_available
      t.datetime :date
      t.references :route, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
