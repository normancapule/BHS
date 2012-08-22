class Account < ActiveRecord::Base
  attr_accessible :address, :birthday, :cellphone, :firstname, :lastname, :nickname
  validates_presence_of :firstname, :lastname
  validate :birthday_checker, :if => "!birthday.nil?"

  has_one :membership
  has_one :user

  def birthday_checker
    begin
      Date.parse birthday.to_s
      true
    rescue
      self.errors[:birthday] << "Birthday is incorrect"
      false
    end
  end
end
