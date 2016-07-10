require 'rails_helper'

RSpec.describe "flights/index", type: :view do
  before(:each) do
    assign(:flights, [
      Flight.create!(
        :route => "Route",
        :stops => 1,
        :plane_name => "Plane Name",
        :seats => 2
      ),
      Flight.create!(
        :route => "Route",
        :stops => 1,
        :plane_name => "Plane Name",
        :seats => 2
      )
    ])
  end

  it "renders a list of flights" do
    render
    assert_select "tr>td", :text => "Route".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Plane Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
