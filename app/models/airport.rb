class Airport < ActiveRecord::Base
  validates :name, presence: true
  validates :country, presence: true
  validates :state, presence: true
  validates :airport_code, presence: true
  def attributes
    { name: name, country: country, state: state, airport_code: airport_code }
  end
end
