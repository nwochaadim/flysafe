require 'rails_helper'

RSpec.describe "routes/new", type: :view do
  before(:each) do
    assign(:route, Route.new(
      :departs => "MyString",
      :arrives => "MyString"
    ))
  end

  it "renders new route form" do
    render

    assert_select "form[action=?][method=?]", routes_path, "post" do

      assert_select "input#route_departs[name=?]", "route[departs]"

      assert_select "input#route_arrives[name=?]", "route[arrives]"
    end
  end
end
