class LandingController < ApplicationController
  def index
    @airport_names = DepartingAirport.all.map do |departing_airport|
        departing_airport.name + " (#{departing_airport.airport_code})"
    end
  end

  def about
    @about_content = Faker::Lorem.paragraphs(3).join(" ")
  end

  def contact_us
  end
end
