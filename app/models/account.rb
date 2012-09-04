class Account < ActiveRecord::Base
  attr_accessible :address, :birthday, :cellphone, :firstname, :lastname, :nickname, :role_id
  validates_presence_of :firstname, :lastname, :role_id

  has_one :membership
  has_one :user
  has_many :customer_transactions, :class_name => "Transaction", :foreign_key => "customer_id"
  has_many :therapist_transactions, :class_name => "Transaction", :foreign_key => "therapist_id"
  
  def self.roles
    {"1"=>"admin", "2"=>"customer", "3"=>"therapist"}
  end

  def self.get_customers
    where("role_id = ?", 2)
  end
  
  def self.get_therapists
    where("role_id = ?", 3)
  end
  
  def transactions
    case role_id
      when 1
        Transaction.all
      when 2
        customer_transactions
      when 3
        therapist_transactions
    end
  end

  def name
    "#{firstname} #{lastname}"
  end
end
