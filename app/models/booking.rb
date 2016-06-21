require "securerandom"
class Booking < ActiveRecord::Base
  before_create :generate_token
  belongs_to :user
end
