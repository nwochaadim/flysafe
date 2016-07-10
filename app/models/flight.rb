class Flight < ActiveRecord::Base
  belongs_to :route
  has_many :bookings
end
