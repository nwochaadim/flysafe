require 'rails_helper'

RSpec.describe "passengers/edit", type: :view do
  before(:each) do
    @passenger = assign(:passenger, Passenger.create!(
      :name => "MyString",
      :sex => "MyString",
      :age => 1,
      :type => ""
    ))
  end

  it "renders the edit passenger form" do
    render

    assert_select "form[action=?][method=?]", passenger_path(@passenger), "post" do

      assert_select "input#passenger_name[name=?]", "passenger[name]"

      assert_select "input#passenger_sex[name=?]", "passenger[sex]"

      assert_select "input#passenger_age[name=?]", "passenger[age]"

      assert_select "input#passenger_type[name=?]", "passenger[type]"
    end
  end
end
