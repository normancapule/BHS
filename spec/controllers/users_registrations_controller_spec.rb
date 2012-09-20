require 'spec_helper'

describe Users::RegistrationsController do
  
  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe "GET 'new'" do 
    it "should be successful" do
      get :new
      response.should be_success
    end

    it "should have an empty user and account variable" do
      get :new
      assigns(:new_user).should_not be_nil
      assigns(:new_account).should_not be_nil
    end
  end

  describe "POST 'create'" do
    before(:each) do
      @user = FactoryGirl.attributes_for :testadmin
      @user[:account] = FactoryGirl.attributes_for :adminaccount
    end
    
    it "should redirect to root if successfully created a user" do
      post :create,
           :user => @user
      response.code.should == "302"
      response.should redirect_to "/"
    end
    
    it "should not redirect to root if there is an error creating a user" do
      @user[:username] = ""
      post :create,
           :user => @user
      response.code.should == "200"
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      @admin = FactoryGirl.create :admin
      sign_in @admin
      @update_user = {"account"=>{"firstname"=>"Test", "lastname"=>@admin.account.lastname, "role_id"=>@admin.account.role_id, "nickname"=>"test", "cellphone"=>@admin.account.cellphone, "address"=>@admin.account.address, "birthday"=>@admin.account.birthday.to_s}, 
                      "username"=>"admin_test", "current_password"=>"123qwe"}
    end

    it "should update the user" do
      put :update,
          :user => @update_user
      response.code.should == "302"
      response.should redirect_to "/"
    end
    
    it "should not update the user without the current password" do
      @update_user[:current_password] = ""
      put :update,
          :user => @update_user
      response.code.should == "200"
    end
  end
end
