require "securerandom"
class Booking < ActiveRecord::Base
  belongs_to :user
  has_many :passengers
  belongs_to :unregistered_user
  belongs_to :flight
end
