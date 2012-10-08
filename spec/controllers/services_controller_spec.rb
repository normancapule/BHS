require 'spec_helper'

describe ServicesController do 
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
    it "should create a service" do
      post :create,
           :service => FactoryGirl.attributes_for(:service)
      Service.all.size.should be > 0
    end
  end

  describe "GET 'edit'" do
    before :each do
      @service = FactoryGirl.create :service
    end
    
    it "should be successful" do
      get :edit,
          :id => @service.id
      response.should be_true
    end
  end

  describe "PUT 'update'" do
    before :each do
      @service = FactoryGirl.create :service
    end
    
    it "should update the service" do
      new_service = FactoryGirl.attributes_for :service
      new_service[:name] = "new service"
      put :update,
          :id => @service.id,
          :service => new_service
      @service.reload.name.should be == new_service[:name]
    end
  end

  describe "DESTROY 'delete'" do
    before :each do
      @service = FactoryGirl.create :service
    end
    
    it "should delete the therapist" do
      delete :destroy,
             :id => @service.id
      lambda {@service.reload}.should raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
