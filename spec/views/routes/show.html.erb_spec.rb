require 'rails_helper'

RSpec.describe "routes/show", type: :view do
  before(:each) do
    @route = assign(:route, Route.create!(
      :departs => "Departs",
      :arrives => "Arrives"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Departs/)
    expect(rendered).to match(/Arrives/)
  end
end
