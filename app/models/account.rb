class Account < ActiveRecord::Base
  attr_accessible :address, :birthday, :cellphone, :firstname, :lastname, :nickname, :role_id
  validates_presence_of :firstname, :lastname, :role_id
  validate :unique_name
  validate :membership_details

  has_one :membership, :dependent => :destroy
  has_one :user, :dependent => :destroy
  has_many :customer_transactions, :class_name => "Transaction", :foreign_key => "customer_id"
  has_many :therapist_transactions, :class_name => "Transaction", :foreign_key => "therapist_id"
  
  def unique_name
    if Account.where("firstname like ? and lastname like ?", firstname, lastname).reject{|x| x.id == self.id}.size > 0
      errors.add :name, "Another account already has that name."
    end
  end
  
  def membership_details
    if member?
      errors.add :name, "Please enter the member's card number." unless membership.valid?
    end
  end

  def self.roles
    {"1"=>"admin", "2"=>"customer", "3"=>"therapist"}
  end

  def self.get_customers
    where("role_id = ?", 2)
  end
  
  def self.get_therapists
    where("role_id = ?", 3)
  end
  
  def self.new_customer attrs = nil, membership = nil
    attrs ? attrs[:role_id] = 2 : attrs = {:role_id => 2}
    me = new attrs
    if membership and membership[:member_type] and membership[:member_type].to_i > 0
      me.build_membership membership
    end
    me
  end

  def self.new_therapist attrs = nil
    attrs ? attrs[:role_id] = 3 : attrs = {:role_id => 3}
    new attrs
  end

  def member?
    membership ? true : false
  end
  
  def get_membership(type = nil)
    case type
      when nil then member? ? membership.membership_type : "N/A"
      when "number" then member? ? membership.member_type : 0
    end
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

  def role
    case role_id
      when 1 then "admin"
      when 2 then "customer"
      when 3 then "therapist"
    end
  end
end
