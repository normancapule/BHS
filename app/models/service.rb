class Service < ActiveRecord::Base
  attr_accessible :member_price_eve, :member_price_morn, :name, :regular_price, :service_type
  validates_presence_of :member_price_eve, :member_price_morn, :name, :regular_price, :service_type
  validates_uniqueness_of :name

  def self.types
    {"1"=>"Member and Non-Member", "2"=> "Members Only"}
  end

  def self.get_services(customer)
    customer.member? ? self.get_services_for_members : self.get_services_for_all
  end
  
  def self.get_services_for_all
    where "service_type = 1"
  end

  def self.get_services_for_members
    where "service_type = 1 OR service_type = 2"
  end

  def get_price(am_pm, customer)
    case am_pm.downcase
      when "am"
        customer.member? ? member_price_morn : regular_price
      when "pm"
        customer.member? ? member_price_eve : regular_price
    end
  end
end
