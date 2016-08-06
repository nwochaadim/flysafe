class CreateAirports < ActiveRecord::Migration
  def change
    create_table :airports do |t|
      t.string :name
      t.string :country
      t.string :state
      t.string :airport_code
      t.string :type

      t.references :route, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
