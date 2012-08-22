require 'spec_helper'

describe Reservation do
  before(:each) do 
    @reserv = FactoryGirl.build :reservation
  end

  it "should have a valid datetime" do
    @reserv.datetime = 1241251251515152
    @reserv.should_not be_valid
  end
end
