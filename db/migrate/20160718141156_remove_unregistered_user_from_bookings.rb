class RemoveUnregisteredUserFromBookings < ActiveRecord::Migration
  def change
    remove_reference :bookings, :unregistered_user, index: true, foreign_key: true
  end
end
