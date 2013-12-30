# == Schema Information
#
# Table name: services
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  service_type_id   :integer
#  member_price_morn :float            default(0.0)
#  member_price_eve  :float            default(0.0)
#  regular_price     :float            default(0.0)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Service < ActiveRecord::Base
  attr_accessible :member_price_eve, :member_price_morn, :name, :regular_price, :service_type_id
  validates_presence_of :member_price_eve, :member_price_morn, :name, :regular_price, :service_type_id
  validates_uniqueness_of :name

  def self.types
    {"1"=>"Member and Non-Member", "2"=> "Members Only"}
  end

  def self.get_services(customer)
    customer.member? ? self.get_services_for_members : self.get_services_for_all
  end
  
  def self.get_services_for_all
    where "service_type_id = 1"
  end

  def self.get_services_for_members
    where "service_type_id = 1 OR service_type_id = 2"
  end

  def service_type
    case service_type_id
      when 1 then "Member and Non-Member"
      when 2 then "Members Only"
    end
  end
  
  def members_only?
    service_type_id == 2
  end

  def get_price(am_pm, customer)
    case am_pm.to_i
      when 1
        customer.member? ? member_price_morn : regular_price
      when 2
        customer.member? ? member_price_eve : regular_price
    end
  end
end
