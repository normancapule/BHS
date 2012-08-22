class Account < ActiveRecord::Base
  attr_accessible :address, :birthday, :cellphone, :membership_id, :name, :nickname
end
