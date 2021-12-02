require 'rails_helper'

RSpec.describe "referrals/show", type: :view do
  before(:each) do
    @referral = assign(:referral, Referral.create!(
      user: nil,
      code: "Code",
      signups: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Code/)
    expect(rendered).to match(/2/)
  end
end
