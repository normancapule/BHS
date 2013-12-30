# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  authentication_token   :string(255)
#  account_id             :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string(255)
#

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
