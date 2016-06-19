class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.references :departing_airport, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
