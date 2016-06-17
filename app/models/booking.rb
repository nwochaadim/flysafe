require "securerandom"
class Booking < ActiveRecord::Base
  before_create :generate_token
  has_and_belongs_to_many :users
  attr_accessor :token

  private
  def generate_token
    loop do
      @token = SecureRandom::hex(6);
      bookings = Booking.where(reference_number: @token)
      break if bookings.empty?
    end
  end
end
