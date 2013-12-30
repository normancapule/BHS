# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  authentication_token   :string(255)
#  account_id             :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string(255)
#

require 'spec_helper'

describe User do
  before(:each) do
    @user = FactoryGirl.build :user
  end

  it "should require a username" do
    no_uname_user = @user
    no_uname_user.username = nil
    no_uname_user.should_not be_valid
  end
  
  it "should reject duplicate usernames" do
    @user.save
    user_with_duplicate_uname = FactoryGirl.build :user
    user_with_duplicate_uname.username = @user.username
    user_with_duplicate_uname.should_not be_valid
  end
  
  it "should require an email address" do
    no_email_user = @user
    no_email_user.email = ""
    no_email_user.should_not be_valid
  end
  
  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = @user
      invalid_email_user.email = 'asdasdasd'
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate emails" do
    @user.save
    user = FactoryGirl.build :user
    user.email = @user.email
    user.should_not be_valid
  end
  
  it "should require an account" do
    user = @user
    user.account_id = nil
    user.should_not be_valid
  end
  
  describe "passwords" do
    it "should have a password attribute" do
      @user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
    
    it "should require a password" do
      user = @user
      user.password = ""
      user.should_not be_valid
    end
  end

  describe "authentication" do
    it "should authenticate with username or email of user" do
      @user = FactoryGirl.create :admin
      User.find_for_authentication(:login => @user.username).should == @user
      User.find_for_authentication(:login => @user.email).should == @user
      @user.destroy
    end
  end
end
