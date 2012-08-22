class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :role_id, :account_id
  # attr_accessible :title, :body
  
  belongs_to :account
  validates_presence_of :role_id, :account_id, :email, :username
  validates_uniqueness_of :username
end