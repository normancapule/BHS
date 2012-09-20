require 'spec_helper'

describe TransactionsController do
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

  describe "GET 'refresh_main_table'" do
    it "should be successful" do
      get :refresh_main_table
      response.should be_true
    end
  end

  describe "POST 'create'" do
    before :each do
      FactoryGirl.create :service
      @customer = FactoryGirl.create :client_non_member_account
      @therapist = FactoryGirl.create :therapist_account
      @services = [Service.first.id]
      @transaction = {"transaction_type"=>"1", "customer_id"=>@customer.id, "therapist_id"=>@therapist.id, "total_price"=>"2", "transac_date"=>"2012-09-20", "notes"=>"asdasdasd"}
    end
    it "should create a transaction" do
      post :create,
           :transaction => @transaction,
           :services => @services
      Transaction.count.should be == 1
    end
  end
end
