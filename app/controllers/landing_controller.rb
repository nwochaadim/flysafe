class LandingController < ApplicationController
  def index
    @airport_names = Airport.pluck(:name, :airport_code)
      .uniq.map do |airport|
        airport[0] + " (#{airport[1]})"
      end
  end

  def about
    @about_content = Faker::Lorem.paragraphs(3).join(" ")
  end

  def contact_us
  end
end
