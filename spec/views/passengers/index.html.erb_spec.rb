require 'rails_helper'

RSpec.describe "passengers/index", type: :view do
  before(:each) do
    assign(:passengers, [
      Passenger.create!(
        :name => "Name",
        :sex => "Sex",
        :age => 1,
        :type => "Type"
      ),
      Passenger.create!(
        :name => "Name",
        :sex => "Sex",
        :age => 1,
        :type => "Type"
      )
    ])
  end

  it "renders a list of passengers" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Sex".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
  end
end
