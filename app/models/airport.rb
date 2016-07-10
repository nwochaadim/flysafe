class Airport < ActiveRecord::Base
  def attributes
    { name: self.name, country: self.country, state: self.state, airport_code: self.airport_code }
  end
end

