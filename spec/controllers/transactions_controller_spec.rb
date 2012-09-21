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

  describe "PUT 'update'" do
    before :each do
      @transaction = FactoryGirl.create :transaction
      @update_transaction = {"notes"=>"TESTME", "customer_id"=>@transaction.customer_id}
      @services = @transaction.services.map(&:id)
    end

    it "should update a transaction" do
      put :update,
          :id => @transaction.id,
          :transaction => @update_transaction,
          :services => @services
      @transaction.reload.notes.should be == "TESTME"
    end
  end

  describe "DELETE 'destroy'" do
    before :each do
      @transaction = FactoryGirl.create :transaction
    end

    it "should delete the transaction" do
      delete :destroy,
             :id => @transaction.id

      lambda {@transaction.reload}.should raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "GET 'show'" do
    before :each do
      @transaction = FactoryGirl.create :transaction
    end
    
    it "should get the selected transaction" do
      get :show,
          :id => @transaction.id

      assigns(:transaction).should_not be_nil
    end
  end
  
  describe "POST 'paid'" do
    before :each do
      @transaction = FactoryGirl.create :transaction
    end

    it "should change the payment status of a transaction" do
      post :paid,
           :id => @transaction.id,
           :paid => "true" 
      @transaction.reload.paid?.should be_true
    end
  end

  describe "DataTable actions" do
    it "should be successful when initialize_transaction_modal" do

    end
  end
end
