require 'rails_helper'

RSpec.describe "bookings/index", type: :view do
  before(:each) do
    assign(:bookings, [
      Booking.create!(
        :reference_number => "Reference Number"
      ),
      Booking.create!(
        :reference_number => "Reference Number"
      )
    ])
  end

  it "renders a list of bookings" do
    render
    assert_select "tr>td", :text => "Reference Number".to_s, :count => 2
  end
end
