require 'spec_helper'

describe CustomersController do 
  before(:each) do
    @admin = FactoryGirl.create(:admin)
    sign_in @admin
  end
  
  describe "GET 'index'" do
    it "should be successful" do
      get :index
      response.should be_true
    end
  end

  describe "GET 'add'" do
    it "should be successful" do
      get :add
      response.should be_true
    end
  end

  describe "POST 'create'" do
    it "should create a new customer that has a membership" do
      post :create,
           :account => FactoryGirl.attributes_for(:client_member_account),
           :card_number => 125124
      Account.get_customers.size.should be > 0
    end
  end

  describe "GET 'edit'" do
    before :each do
      @customer = FactoryGirl.create :client_member_account
    end
    
    it "should be successful" do
      get :edit,
          :id => @customer.id
      response.should be_true
    end
  end

  describe "PUT 'update'" do
    before :each do
      @customer = FactoryGirl.create :client_member_account
    end

    it "should update the customer" do
      new_customer = FactoryGirl.attributes_for :client_member_account
      new_customer[:firstname] = "Hello World"
      new_customer[:membership] = 1
      put :update,
          :id => @customer.id,
          :card_number => @customer.membership.card_number,
          :account => new_customer
      @customer.reload.firstname.should be == "Hello World"
    end
    
    it "should update the customer to a non-member" do
      new_customer = FactoryGirl.attributes_for :client_non_member_account
      new_customer[:membership] = 0
      put :update,
          :id => @customer.id,
          :account => new_customer 
      @customer.reload.membership.should be_nil
    end
  end

  describe "DESTROY 'delete'" do
    before :each do
      @customer = FactoryGirl.create :client_member_account
    end
    
    it "should delete the therapist" do
      delete :destroy,
             :id => @customer.id
      lambda {@customer.reload}.should raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
