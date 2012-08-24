class Account < ActiveRecord::Base
  attr_accessible :address, :birthday, :cellphone, :firstname, :lastname, :nickname
  validates_presence_of :firstname, :lastname

  has_one :membership
  has_one :user
end
