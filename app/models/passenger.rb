class Passenger < ActiveRecord::Base
  belongs_to :user
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :age_grade, presence: true
end
