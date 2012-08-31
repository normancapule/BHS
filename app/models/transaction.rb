class Transaction < ActiveRecord::Base
  attr_accessible :customer_id, :notes, :paid, :therapist_id, :total_price, :transaction_type, :transac_date
  validates_presence_of :total_price, :transaction_type, :transac_date
  
  belongs_to :customer, :class_name => 'Account'
  belongs_to :therapist, :class_name => 'Account'
  has_many :transaction_details
  has_many :services, :through => :transaction_details

  scope :custom_sort, lambda{|sort_column, sort_direction|
    case sort_column
      when "customer", "therapist"
        joins(:"#{sort_column}").order("lastname #{sort_direction}")
      when "total_price", "paid"
        order("#{sort_column} #{sort_direction}")
    end
  }
  
  def self.types#what is this?
    {}
  end

  def self.of_date(date)
    where("transac_date = ?", date)
  end
end
