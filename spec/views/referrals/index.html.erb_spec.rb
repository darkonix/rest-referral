require 'rails_helper'

RSpec.describe "referrals/index", type: :view do
  before(:each) do
    assign(:referrals, [
      Referral.create!(
        user: nil,
        code: "Code",
        signups: 2
      ),
      Referral.create!(
        user: nil,
        code: "Code",
        signups: 2
      )
    ])
  end

  it "renders a list of referrals" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "Code".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
  end
end
