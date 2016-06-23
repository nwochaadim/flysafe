class Passenger < ActiveRecord::Base
  belongs_to :booking
  validates :first_name, presence: true
  validates :last_name, presence: true
end
