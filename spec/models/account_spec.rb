require 'spec_helper'

describe Account do
  before(:each) do 
    @user = FactoryGirl.build :clientnonmember
    @account = @user.account
    @memberaccount = FactoryGirl.build(:clientmember).account
  end

  it "should have first and last names" do
    @account.firstname.should_not be_nil
    @account.lastname.should_not be_nil
  end

  it "should have membership details if member" do
    @memberaccount.membership.should_not be_nil
  end
end
