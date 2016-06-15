require 'rails_helper'

RSpec.describe "flights/edit", type: :view do
  before(:each) do
    @flight = assign(:flight, Flight.create!(
      :route => "MyString",
      :stops => 1,
      :plane_name => "MyString",
      :seats => 1
    ))
  end

  it "renders the edit flight form" do
    render

    assert_select "form[action=?][method=?]", flight_path(@flight), "post" do

      assert_select "input#flight_route[name=?]", "flight[route]"

      assert_select "input#flight_stops[name=?]", "flight[stops]"

      assert_select "input#flight_plane_name[name=?]", "flight[plane_name]"

      assert_select "input#flight_seats[name=?]", "flight[seats]"
    end
  end
end
