class LandingController < ApplicationController
  def index
    @airport_names = Airport.names
  end

  def about
    @about_content = Faker::Lorem.paragraphs(3).join(" ")
  end

  def contact_us
  end

  def create_feedback
    @contact = Contact.new(landing_params)

    if @contact.save
      redirect_to :root, notice: feedback_success
    else
      render :contact_us, notice: feedback_error
    end
  end

  private

  def landing_params
    params.permit(:first_name, :last_name, :email, :phone_number, :comment)
  end
end
