class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessor :login
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :account_id, :login
  # attr_accessible :title, :body
  validates_presence_of :username
  validates_uniqueness_of :username
  
  belongs_to :account

  def self.find_for_authentication(conditions)
    login = conditions[:login]
    where(["username = :value OR email = :value", { :value => login }]).first
  end
end
