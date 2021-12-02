require 'rails_helper'

RSpec.describe "referrals/new", type: :view do
  before(:each) do
    assign(:referral, Referral.new(
      user: nil,
      code: "MyString",
      signups: 1
    ))
  end

  it "renders new referral form" do
    render

    assert_select "form[action=?][method=?]", referrals_path, "post" do

      assert_select "input[name=?]", "referral[user_id]"

      assert_select "input[name=?]", "referral[code]"

      assert_select "input[name=?]", "referral[signups]"
    end
  end
end
