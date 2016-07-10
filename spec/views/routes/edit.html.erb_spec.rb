require 'rails_helper'

RSpec.describe "routes/edit", type: :view do
  before(:each) do
    @route = assign(:route, Route.create!(
      :departs => "MyString",
      :arrives => "MyString"
    ))
  end

  it "renders the edit route form" do
    render

    assert_select "form[action=?][method=?]", route_path(@route), "post" do

      assert_select "input#route_departs[name=?]", "route[departs]"

      assert_select "input#route_arrives[name=?]", "route[arrives]"
    end
  end
end
