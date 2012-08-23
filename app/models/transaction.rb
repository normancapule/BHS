class Transaction < ActiveRecord::Base
  attr_accessible :customer_id, :notes, :paid, :therapist_id, :total_price, :transaction_type
  validates_presence_of :total_price, :transaction_type
  
  belongs_to :customer, :class_name => 'User'
  belongs_to :therapist, :class_name => 'User'
  has_many :transaction_details
  has_many :services, :through => :transaction_details

  def self.different_types
    {}
  end
end
