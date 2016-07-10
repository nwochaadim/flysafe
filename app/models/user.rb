class User < ActiveRecord::Base
  has_and_belongs_to_many :bookings
  has_many :passengers
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
end
