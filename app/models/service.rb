class Service < ActiveRecord::Base
  attr_accessible :member_price_eve, :member_price_morn, :name, :regular_price, :service_type
  validates_presence_of :member_price_eve, :member_price_morn, :name, :regular_price, :service_type

  def self.types
    {"1"=>"Non-Member", "2"=> "Member"}
  end

  def get_price(am_pm)
    case am_pm
      when "am"
        service_type == 1 ? regular_price : member_price_morn
      when "pm"
        service_type == 1 ? regular_price : member_price_eve
    end
  end
end
