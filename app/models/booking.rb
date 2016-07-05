require "securerandom"
class Booking < ActiveRecord::Base
  belongs_to :user
  has_many :passengers
  belongs_to :unregistered_user
  belongs_to :flight
  validates :reference_number, presence: true, uniqueness: true
  validates :class_level, presence: true

  def addPassengers(passengers)
    createAdultPassengers(passengers["adult"]) if passengers["adult"]
    createChildPassengers(passengers["child"]) if passengers["child"]
    createInfantPassengers(passengers["infant"]) if passengers["infant"]
  end

  def createAdultPassengers(adults)
    adults.each do |adult|
      self.passengers.create(
        first_name: adult["first_name"], 
        last_name: adult["last_name"],
        age_grade: "Adult"
        )
    end
  end

  def createChildPassengers(children)
    children.each do |child|
      self.passengers.create(
        first_name: child["first_name"], 
        last_name: child["last_name"],
        age_grade: "Child"
        )
    end
  end

  def createInfantPassengers(infants)
    infants.each do |infant|
      self.passengers.create(
        first_name: infant["first_name"], 
        last_name: infant["last_name"],
        age_grade: "Infant"
        )
    end
  end

  def allocate_flight(flight)
    passengers = self.passengers.where("age_grade = 'Adult' or age_grade = 'Child'")
    seats_available = flight.seats_available - passengers.count
    flight.update(seats_available: seats_available) 
    self.update(flight: flight)
  end
end
