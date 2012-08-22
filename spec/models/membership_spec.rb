require 'spec_helper'

describe Membership do
  before(:each) do
    @user = FactoryGirl.build :clientmember
    @membership = @user.account.membership
  end

  it "should have a card number" do
    @membership.card_number.should_not be_nil
  end
end
