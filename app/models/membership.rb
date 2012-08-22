class Membership < ActiveRecord::Base
  attr_accessible :account_id, :card_number
  validates_presence_of :account_id, :card_number
  
  belongs_to :account
end
