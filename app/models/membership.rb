class Membership < ActiveRecord::Base
  attr_accessible :account_id, :card_number, :member_type
  validates_presence_of :card_number, :member_type
  
  belongs_to :account

  def self.types
    {"1"=>"Personalized", "2"=>"Family", "3"=>"Child"}
  end

  def membership_type
    case member_type
      when 1
        "Personalized"
      when 2
        "Family"
      when 3
        "Child"
    end
  end
end
