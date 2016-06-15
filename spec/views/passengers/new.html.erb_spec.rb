require 'rails_helper'

RSpec.describe "passengers/new", type: :view do
  before(:each) do
    assign(:passenger, Passenger.new(
      :name => "MyString",
      :sex => "MyString",
      :age => 1,
      :type => ""
    ))
  end

  it "renders new passenger form" do
    render

    assert_select "form[action=?][method=?]", passengers_path, "post" do

      assert_select "input#passenger_name[name=?]", "passenger[name]"

      assert_select "input#passenger_sex[name=?]", "passenger[sex]"

      assert_select "input#passenger_age[name=?]", "passenger[age]"

      assert_select "input#passenger_type[name=?]", "passenger[type]"
    end
  end
end
