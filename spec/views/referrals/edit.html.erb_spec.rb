require 'rails_helper'

RSpec.describe "referrals/edit", type: :view do
  before(:each) do
    @referral = assign(:referral, Referral.create!(
      user: nil,
      code: "MyString",
      signups: 1
    ))
  end

  it "renders the edit referral form" do
    render

    assert_select "form[action=?][method=?]", referral_path(@referral), "post" do

      assert_select "input[name=?]", "referral[user_id]"

      assert_select "input[name=?]", "referral[code]"

      assert_select "input[name=?]", "referral[signups]"
    end
  end
end
