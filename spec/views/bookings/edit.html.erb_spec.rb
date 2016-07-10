require 'rails_helper'

RSpec.describe "bookings/edit", type: :view do
  before(:each) do
    @booking = assign(:booking, Booking.create!(
      :reference_number => "MyString"
    ))
  end

  it "renders the edit booking form" do
    render

    assert_select "form[action=?][method=?]", booking_path(@booking), "post" do

      assert_select "input#booking_reference_number[name=?]", "booking[reference_number]"
    end
  end
end
