require 'spec_helper'

describe ReservationsController do
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
    it "should create a new reservation" do
      post :create,
           :reservation => {:name=>"Hello World", :number_people=>"1"},
           :add_date => "2012-10-08",
           :hour=>"11", 
           :minutes=>"35", 
           :am_pm=>"AM"
      Reservation.all.size.should be > 0
    end
  end

  describe "GET 'edit'" do
    before :each do
      @reservation = FactoryGirl.create :reservation
    end

    it "should be successful" do
      get :edit,
          :id => @reservation.id
      response.should be_true
    end
  end

  describe "PUT 'update'" do
    before :each do
      @reservation = FactoryGirl.create :reservation
    end
    
    it "should update the  reservation" do
      put :update,
          :id => @reservation.id,
          :reservation => {:name=>"Hello World2", :number_people=>"1"},
          :edit_date => @reservation.datetime.to_date.to_s,
          :hour=>@reservation.datetime.strftime("%l"), 
          :minutes=>@reservation.datetime.strftime("%M"), 
          :am_pm=>"PM"
      @reservation.reload.name.should be == "Hello World2"
    end
  end

  describe "DESTROY 'delete'" do
    before :each do
      @reservation = FactoryGirl.create :reservation
    end
    
    it "should delete the therapist" do
      delete :destroy,
             :id => @reservation.id
      lambda {@reservation.reload}.should raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
