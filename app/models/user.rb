class User < ActiveRecord::Base
  has_and_belongs_to_many :bookings
  has_many :passengers
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  
end
