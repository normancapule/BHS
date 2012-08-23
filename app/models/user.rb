class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :role_id, :account_id
  # attr_accessible :title, :body
  validates_presence_of :role_id, :username
  validates_uniqueness_of :username
  
  belongs_to :account
  has_many :transactions

  def self.different_roles
    {"1"=>"admin", "2"=>"client", "3"=>"therapist"}
  end
end
