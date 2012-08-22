class Transaction < ActiveRecord::Base
  attr_accessible :customer_id, :notes, :paid, :therapist_id, :total_price, :type
  validates_presence_of :customer_id, :therapist_id, :total_price, :type
  
  belongs_to :customer, :class_name => 'User'
  belongs_to :therapist, :class_name => 'User'
  def self.different_types
    {}
  end
end
