require 'rails_helper'

RSpec.describe "flights/new", type: :view do
  before(:each) do
    assign(:flight, Flight.new(
      :route => "MyString",
      :stops => 1,
      :plane_name => "MyString",
      :seats => 1
    ))
  end

  it "renders new flight form" do
    render

    assert_select "form[action=?][method=?]", flights_path, "post" do

      assert_select "input#flight_route[name=?]", "flight[route]"

      assert_select "input#flight_stops[name=?]", "flight[stops]"

      assert_select "input#flight_plane_name[name=?]", "flight[plane_name]"

      assert_select "input#flight_seats[name=?]", "flight[seats]"
    end
  end
end
