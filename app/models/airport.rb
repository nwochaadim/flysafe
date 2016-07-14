class Airport < ActiveRecord::Base
  validates :name, presence: true
  validates :country, presence: true
  validates :state, presence: true
  validates :airport_code, presence: true
end
