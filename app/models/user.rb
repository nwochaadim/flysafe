class User < ActiveRecord::Base
  has_and_belongs_to_many :bookings
  has_many :passengers
end
