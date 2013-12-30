# == Schema Information
#
# Table name: memberships
#
#  id          :integer          not null, primary key
#  account_id  :integer
#  card_number :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  member_type :integer
#

require 'spec_helper'

describe Membership do
  before(:each) do
    @membership = FactoryGirl.build :family
  end

  it "should have a card number" do
    @membership.card_number.should_not be_nil
  end

  it "should get all kinds of roles" do
    Membership.types
  end

  it "should get membership type" do
    @membership.membership_type.should be == "Family"
  end
end
