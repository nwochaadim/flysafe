require 'rails_helper'

RSpec.describe "airports/new", type: :view do
  before(:each) do
    assign(:airport, Airport.new(
      :name => "MyString",
      :location => "MyString"
    ))
  end

  it "renders new airport form" do
    render

    assert_select "form[action=?][method=?]", airports_path, "post" do

      assert_select "input#airport_name[name=?]", "airport[name]"

      assert_select "input#airport_location[name=?]", "airport[location]"
    end
  end
end
