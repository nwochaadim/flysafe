class LandingController < ApplicationController
  def index
    @airport_names = Airport.pluck(:name, :airport_code)
      .uniq.map do |airport|
        airport[0] + " (#{airport[1]})"
      end
  end

  def about
    @about_content = Faker::Lorem.paragraphs(3).join(' ')
  end

  def contact_us
  end

  def create_feedback
    @contact = Contact.new(feedback_params)
    if @contact.save
      redirect_to :root_path, notice: "Your Enquiry received succesfully"
    else
      render :contact_us, notice: "Some fields are missing"
    end
  end

  private

  def feedback_params
    params.permit(:first_name, :last_name, :email, :phone_number, :comment)
  end
end
