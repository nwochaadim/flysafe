require 'rails_helper'

RSpec.describe "airports/show", type: :view do
  before(:each) do
    @airport = assign(:airport, Airport.create!(
      :name => "Name",
      :location => "Location"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Location/)
  end
end
