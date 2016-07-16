require "securerandom"
class Booking < ActiveRecord::Base
  belongs_to :user
  has_many :passengers
  belongs_to :unregistered_user
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
      passengers.create(passenger.merge(age_grade: type.capitalize))
    end
  end

  def update_passengers(passengers_param)
    retrieved_user = user || unregistered_user
    retrieved_user.update(
      first_name: passengers_param[:first_name],
      last_name: passengers_param[:last_name],
      email: passengers_param[:email]
    )
    passengers.destroy_all
    add_passengers(passengers_param)
  end

  def allocate_flight(flight)
    total_passengers = passengers.where.not("age_grade = 'Infant'").count
    seats_available = flight.seats_available - total_passengers
    flight.update(seats_available: seats_available)
    update(flight: flight)
  end
end
