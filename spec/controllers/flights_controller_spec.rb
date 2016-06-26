require 'rails_helper'

RSpec.describe FlightsController, type: :controller do
  let(:valid_attributes) {
    {
      departs: "Abuja Intenational Airport (ABV)",
      arrives: "Benin Airport (BNI)",
      grade: "Economy",
      adults: "1",
      children: "1",
      infants: "1",
      date: "2016-06-27"
    }
  }

  describe "GET #search" do
    it "renders search template" do
      valid_attributes.merge!(format: :js)
      get :search, valid_attributes
      expect(response).to render_template(:search)
    end
  end

end
