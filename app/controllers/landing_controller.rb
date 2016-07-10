class LandingController < ApplicationController
  def index
    
  end

  def about
    @about_content = Faker::Lorem.paragraphs(3).join(" ")
  end

  def contact_us
  end
end
