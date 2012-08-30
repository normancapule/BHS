require 'spec_helper'

describe PagesController do
  before(:all) do
    @reserv = FactoryGirl.build :reservation
    @reserv.datetime.change :month => 1
    @reserv.save
    (1..3).each do
      @reserv = FactoryGirl.create :reservation
    end
  end
  
  before(:each) do
    @admin = FactoryGirl.create(:admin)
    sign_in @admin
  end
  
  describe "GET 'index'" do
    it "should list all reservations for today" do
      get :index
      assigns(:reservations).each do |x|
        (DateTime.current.beginning_of_day <= x.datetime and x.datetime <= DateTime.current.end_of_day).should be_true
      end
    end
  end

  describe "POST 'create_reservation'" do
    it "should create a new reservation" do
      post :create_reservation,
          :reservation => FactoryGirl.attributes_for(:reservation)
      response.code.should == "200"
    end
  end

  describe "DELETE 'delete_reservation'" do
    it "should delete a reservation" do
      post :delete_reservation,
          :id => Reservation.last.id
      response.code.should == "200"
    end
  end

  describe "POST 'update_reservation'" do
    it "should update a reservation" do
      reservation = {:id => Reservation.last.id, :name => "test_me"}
      post :update_reservation,
           :reservation => reservation
      Reservation.last.name.should == "test_me"
      response.code.should == "200"
    end
  end

  describe "POST 'edit_reservation'" do
    it "should have the reservation to be edited" do
      post :edit_reservation,
           :id => Reservation.last.id
      assigns(:reservation).should == Reservation.last
    end
  end
end
