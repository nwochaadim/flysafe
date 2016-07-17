class Airport < ActiveRecord::Base
  validates :name, presence: true
  validates :country, presence: true
  validates :state, presence: true
  validates :airport_code, presence: true

  def self.names
    Airport.pluck(:name, :airport_code).uniq.map do |airport|
      airport[0] + " (#{airport[1]})"
    end
  end
end
