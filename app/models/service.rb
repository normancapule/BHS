class Service < ActiveRecord::Base
  attr_accessible :member_price_eve, :member_price_morn, :name, :regular_price, :service_type
  validates_presence_of :member_price_eve, :member_price_morn, :name, :regular_price, :service_type

  def self.different_types
    {"1"=>"Non-Member", "2"=> "Member"}
  end
end
