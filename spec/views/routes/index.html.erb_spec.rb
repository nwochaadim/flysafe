require 'rails_helper'

RSpec.describe "routes/index", type: :view do
  before(:each) do
    assign(:routes, [
      Route.create!(
        :departs => "Departs",
        :arrives => "Arrives"
      ),
      Route.create!(
        :departs => "Departs",
        :arrives => "Arrives"
      )
    ])
  end

  it "renders a list of routes" do
    render
    assert_select "tr>td", :text => "Departs".to_s, :count => 2
    assert_select "tr>td", :text => "Arrives".to_s, :count => 2
  end
end
