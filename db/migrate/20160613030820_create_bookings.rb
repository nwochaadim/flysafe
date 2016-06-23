class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :reference_number, null: false
      t.references :flight, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :unregistered_user, index: true, foreign_key: true
      t.string :class_level

      t.timestamps null: false
    end
  end
end
