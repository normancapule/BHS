require 'spec_helper'

describe Reservation do
  before(:each) do 
    @reserv = FactoryGirl.build :reservation
  end
  
  describe "helper methods" do
    it "should return all reservations given the date" do
      Reservation.for_today nil, nil, Date.current.to_s
    end
  end
  describe "formatted data" do
    it "should give you formatted time" do
      @reserv.formatted_time
    end
    it "should give you hours in 12-hour format" do
      @reserv.hour_12.to_i < 13
    end
    it "should give you formatted minute" do
      @reserv.minute
    end
    it "should give you AM/PM depending on time cycle" do
      ["AM", "PM"].include? @reserv.am_pm
    end
  end
end
