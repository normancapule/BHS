require 'spec_helper'

describe PagesController do
  
  before(:each) do
    @admin = FactoryGirl.create(:admin)
    sign_in @admin
  end
  
  describe "GET 'index'" do
    it "should list all reservations only for today" do
      get :index
      response.should be_success
    end
  end

  describe "POST 'create_reservation'" do
    it "should create a new reservation" do
      post :create_reservation,
           :reservation => FactoryGirl.attributes_for(:reservation),
           :format => :js
      response.code.should == "200"
    end
  end

  describe "DELETE 'delete_reservation'" do
    before(:each) do
      @reserv = FactoryGirl.build :reservation
      @reserv.datetime.change :month => 1
      @reserv.save
      (1..3).each do
        @reserv = FactoryGirl.create :reservation
      end
    end
    it "should delete a reservation" do
      post :delete_reservation,
           :id => Reservation.last.id,
           :format => :js

      response.code.should == "200"
    end
  end

  describe "POST 'update_reservation'" do
    before(:each) do
      @reserv = FactoryGirl.build :reservation
      @reserv.datetime.change :month => 1
      @reserv.save
      (1..3).each do
        @reserv = FactoryGirl.create :reservation
      end
    end
    it "should update a reservation" do
      reservation = {:id => Reservation.last.id, :name => "test_me"}
      post :update_reservation,
           :reservation => reservation,
           :format => :js

      Reservation.last.name.should == "test_me"
      response.code.should == "200"
    end
  end

  describe "POST 'edit_reservation'" do
    before(:each) do
      @reserv = FactoryGirl.build :reservation
      @reserv.datetime.change :month => 1
      @reserv.save
      (1..3).each do
        @reserv = FactoryGirl.create :reservation
      end
    end
    it "should have the reservation to be edited" do
      post :edit_reservation,
           :id => Reservation.last.id
      assigns(:reservation).should == Reservation.last
    end
  end
end
