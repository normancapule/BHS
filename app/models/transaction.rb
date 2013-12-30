# == Schema Information
#
# Table name: transactions
#
#  id               :integer          not null, primary key
#  customer_id      :integer
#  total_price      :float            default(0.0)
#  therapist_id     :integer
#  notes            :text
#  paid             :boolean          default(FALSE)
#  transaction_type :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  transac_date     :date
#

class Transaction < ActiveRecord::Base
  attr_accessible :customer_id, :notes, :paid, :therapist_id, :total_price, :transaction_type, :transac_date
  validates_presence_of :total_price, :transaction_type, :transac_date
  validate :validate_service_count, :validate_customer, :validate_therapist

  belongs_to :customer, :class_name => 'Account'
  belongs_to :therapist, :class_name => 'Account'  
  has_many :transaction_details, :dependent => :destroy
  has_many :services, :through => :transaction_details

  scope :custom_sort, lambda{|sort_column, sort_direction|
    case sort_column
      when "customer", "therapist"
        joins(:"#{sort_column}").order("lastname #{sort_direction}")
      when "total_price", "paid"
        order("#{sort_column} #{sort_direction}")
    end
  }
  
  def validate_service_count
    if services.length == 0
      errors.add :services, "are not present"
    end
  end

  def validate_customer
    if customer.nil?
      errors.add :customer, "is not present"
    end
  end

  def validate_therapist
    if therapist.nil?
      errors.add :therapist, "is not present"
    end
  end

  def get_type
    case transaction_type
      when 1 then "AM"
      when 2 then "PM"
    end
  end  
  
  def compute_total_price(c = nil)
    sum = 0
    c = customer if c.nil?
    services.each {|x| sum += x.get_price(transaction_type,c)}
    sum
  end

  def self.types
    {"1" => "AM", "2" => "PM"}
  end

  def self.of_date(date)
    where("transac_date = ?", date)
  end
end
