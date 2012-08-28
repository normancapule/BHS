class Account < ActiveRecord::Base
  attr_accessible :address, :birthday, :cellphone, :firstname, :lastname, :nickname, :role_id
  validates_presence_of :firstname, :lastname, :role_id

  has_one :membership
  has_one :user
  
  def self.roles
    {"1"=>"admin", "2"=>"client", "3"=>"therapist"}
  end
end
