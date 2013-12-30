# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  firstname  :string(255)
#  lastname   :string(255)
#  nickname   :string(255)
#  cellphone  :integer
#  address    :text
#  birthday   :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  role_id    :integer
#

require 'spec_helper'

describe Account do
  before(:each) do
    @nonmemberaccount = FactoryGirl.build :client_non_member_account
    @memberaccount = FactoryGirl.build :client_member_account
    @therapistaccount = FactoryGirl.build :therapist_account
  end

  it "should have first and last names" do
    @nonmemberaccount.firstname.should_not be_nil
    @nonmemberaccount.lastname.should_not be_nil
  end

  it "should have membership details if member" do
    @memberaccount.membership.should_not be_nil
  end
  
  it "should have a unique name" do
    @memberaccount.save
    new_account = FactoryGirl.build :client_member_account
    new_account.valid?.should be_false
    new_account.errors[:name].size.should be > 0
  end

  it "should require a role" do
    @nonmemberaccount.role_id = nil
    @nonmemberaccount.should_not be_valid
  end

  it "should display all available roles" do
    Account.roles
  end

  it "should get all customer accounts" do
    @nonmemberaccount.save
    @memberaccount.save
    @therapistaccount.save
    Account.get_customers.map(&:role_id).uniq.join.should be == "2"
  end
  
  it "should get all customer accounts" do
    @nonmemberaccount.save
    @memberaccount.save
    @therapistaccount.save
    Account.get_therapists.map(&:role_id).uniq.join.should be == "3"
  end

  it "should get the membership" do
    @memberaccount.get_membership.should be == "Family"
    @memberaccount.get_membership("number").should be == 2
  end

  it "should get the transaction depending on role" do
    @nonmemberaccount.transactions
    @therapistaccount.transactions
  end

  it "should get the account's role" do
    @memberaccount.role.should be == "customer"
    @therapistaccount.role.should be =="therapist"
  end
end
