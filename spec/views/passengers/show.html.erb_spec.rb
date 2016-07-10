require 'rails_helper'

RSpec.describe "passengers/show", type: :view do
  before(:each) do
    @passenger = assign(:passenger, Passenger.create!(
      :name => "Name",
      :sex => "Sex",
      :age => 1,
      :type => "Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Sex/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Type/)
  end
end
