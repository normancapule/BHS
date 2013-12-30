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

FactoryGirl.define do
  factory :user do
    password '123qwe'
    password_confirmation '123qwe'

    factory :me do
      username 'admin'
      email 'carenebernardo@gmail.com'
      password 'glenda2012'
      password_confirmation 'glenda2012'
      after(:build) do |user|
        user.account = FactoryGirl.build(:meaccount)
      end
    end
    
    factory :admin do
      username 'admin'
      email 'admin@example.com'
      after(:build) do |user|
        user.account = FactoryGirl.build(:adminaccount)
      end
    end
    
    factory :testadmin do
      username 'admin'
      email 'admin@example.com'
      after(:build) do |user|
        user.account = FactoryGirl.build(:adminaccount)
      end
    end

    factory :clientnonmember do
      username 'clientnonmember'
      email 'cnm@example.com'
      after(:build) do |user|
        user.account = FactoryGirl.build(:client_non_member_account)
      end
    end

    factory :clientmember do
      username 'clientmember'
      email 'cm@example.com'
      after(:build) do |user|
        user.account = FactoryGirl.build(:client_member_account)
      end
    end

    factory :therapist do
      username 'therapist'
      email 'tp@example.com'
      after(:build) do |user|
        user.account = FactoryGirl.build(:therapist_account)
      end
    end
  end
end
