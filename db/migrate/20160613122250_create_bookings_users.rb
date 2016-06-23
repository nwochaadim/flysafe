class CreateBookingsUsers < ActiveRecord::Migration
  def change
    create_table :bookings_users do |t|
      t.references :booking, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      
      t.timestamps null: false
    end
  end
end
