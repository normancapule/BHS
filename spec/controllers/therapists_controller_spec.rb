require 'spec_helper'

describe TherapistsController do
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
    it "should create a new therapist" do
      post :create,
           :account => {:firstname => "master", :lastname => "tester"}
      Account.get_therapists.size.should be > 0
    end
  end

  describe "GET 'edit'" do
    before :each do
      @therapist = FactoryGirl.create :therapist_account
    end

    it "should be successful" do
      get :edit,
          :id => @therapist.id
      response.should be_true
    end
  end

  describe "PUT 'update'" do
    before :each do
      @therapist = FactoryGirl.create :therapist_account
    end
   
    it "should update the therapist" do
      put :update,
          :account => {:firstname => "test"},
          :id => @therapist.id
      @therapist.reload.firstname.should be == "test"
    end
  end

  describe "DELETE 'destroy'" do
    before :each do
      @therapist = FactoryGirl.create :therapist_account
    end
    
    it "should delete the therapist" do
      delete :destroy,
             :id => @therapist.id
      lambda {@therapist.reload}.should raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
