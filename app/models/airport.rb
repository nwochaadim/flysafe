class Airport < ActiveRecord::Base
  validates :name, presence: true
  validates :country, presence: true
  validates :state, presence: true
  validates :airport_code, presence: true

  has_many :departing_flights, foreign_key: :from_airport_id, class_name: "Flight"
  has_many :arriving_flights, foreign_key: :to_airport_id, class_name: "Flight"

  def self.names
    Airport.pluck(:name, :airport_code).uniq.map do |airport|
      airport[0] + " (#{airport[1]})"
    end
  end
end
