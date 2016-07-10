require 'rails_helper'

RSpec.describe "airports/index", type: :view do
  before(:each) do
    assign(:airports, [
      Airport.create!(
        :name => "Name",
        :location => "Location"
      ),
      Airport.create!(
        :name => "Name",
        :location => "Location"
      )
    ])
  end

  it "renders a list of airports" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
  end
end
