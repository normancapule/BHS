class Membership < ActiveRecord::Base
  attr_accessible :account_id, :card_number, :member_type
  validates_presence_of :card_number, :member_type
  
  belongs_to :account

  def self.member_types
    {"1"=>"personalized", "2"=>"Family", "3"=>"Child"}
  end
end
