class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :departs
      t.string :arrives
      t.datetime :date
      t.references :flight, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
