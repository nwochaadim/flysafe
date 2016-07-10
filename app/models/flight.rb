class Flight < ActiveRecord::Base
  has_many :routes
  has_many :bookings
end
