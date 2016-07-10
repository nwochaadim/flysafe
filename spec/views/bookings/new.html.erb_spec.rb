require 'rails_helper'

RSpec.describe "bookings/new", type: :view do
  before(:each) do
    assign(:booking, Booking.new(
      :reference_number => "MyString"
    ))
  end

  it "renders new booking form" do
    render

    assert_select "form[action=?][method=?]", bookings_path, "post" do

      assert_select "input#booking_reference_number[name=?]", "booking[reference_number]"
    end
  end
end
