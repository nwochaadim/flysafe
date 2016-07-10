class Route < ActiveRecord::Base
  belongs_to :departing_airport
  has_one :arriving_airport
  has_one :flight
end
