require 'spec_helper'
require 'pry'

describe TransactionsController do
  before :each do
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
    it "should create a transaction" do
      @customer = FactoryGirl.create :client_non_member_account
      @therapist = FactoryGirl.create :therapist_account
      @services = [FactoryGirl.create(:service).id]
      @transaction_attr = {"transaction_type"=>"1", "customer_id"=>@customer.id, "therapist_id"=>@therapist.id, "total_price"=>"2", "transac_date"=>"2012-09-20", "notes"=>"asdasdasd"}
      post :create,
           :transaction => @transaction_attr,
           :services => @services
      Transaction.count.should be > 0
    end
  end

  describe "PUT 'update'" do
    it "should update a transaction" do
      transaction = FactoryGirl.create(:transaction)
      @update_transaction = {"notes"=>"TESTME", "customer_id"=>transaction.customer_id}
      @services = transaction.services.map(&:id)
      put :update,
          :id => transaction.id,
          :transaction => @update_transaction,
          :services => @services
      transaction.reload.notes.should be == "TESTME"
    end
  end

  describe "POST 'paid'" do
    it "should change the payment status of a transaction" do
      transaction = FactoryGirl.create(:transaction)
      post :paid,
           :id => transaction.id,
           :paid => "true" 
      transaction.reload.paid?.should be_true
    end
  end
  
  describe "GET 'show'" do
    it "should get the selected transaction" do
      transaction = FactoryGirl.create(:transaction)
      get :show,
          :id => transaction.id

      assigns(:transaction).should_not be_nil
    end
  end
  
  describe "DataTable actions" do
    it "should be successful when initialize_transaction_modal" do

    end
  end
  
  describe "DELETE 'destroy'" do
    it "should delete the transaction" do
      transaction = FactoryGirl.create(:transaction)
      delete :destroy,
             :id => transaction.id

      lambda {transaction.reload}.should raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
