require "securerandom"
class Booking < ActiveRecord::Base
  belongs_to :user
  has_many :passengers
  belongs_to :flight
  validates :reference_number, presence: true, uniqueness: true
  validates :class_level, presence: true

  def add_passengers(passenger_params)
    %w(adult child infant).each do |type|
      create_passengers(passenger_params[type], type) if passenger_params[type]
    end
  end

  def create_passengers(passenger_param, type)
    passenger_param.each do |passenger|
      passenger = passenger.merge(age_grade: type.capitalize)
      passengers << Passenger.create(passenger)
      save
    end
  end

  def update_passengers(passengers_param)
    passengers.destroy_all
    add_passengers(passengers_param)
  end

  def allocate_flight(flight)
    total_passengers = passengers.where.not("age_grade = 'Infant'").count
    seats_available = flight.seats_available - total_passengers
    flight.update(seats_available: seats_available)
    update(flight: flight)
  end

  def self.create_and_allocate(flight, reference, class_level, params, user)
    booking = self.create(reference_number: reference, class_level: class_level)
    booking.add_passengers(params)
    booking.allocate_flight(flight)
    booking.update(user: user) if booking
    booking
  end
end
