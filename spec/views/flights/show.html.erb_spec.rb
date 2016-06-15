require 'rails_helper'

RSpec.describe "flights/show", type: :view do
  before(:each) do
    @flight = assign(:flight, Flight.create!(
      :route => "Route",
      :stops => 1,
      :plane_name => "Plane Name",
      :seats => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Route/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Plane Name/)
    expect(rendered).to match(/2/)
  end
end
