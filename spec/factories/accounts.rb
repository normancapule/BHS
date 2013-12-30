# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  firstname  :string(255)
#  lastname   :string(255)
#  nickname   :string(255)
#  cellphone  :integer
#  address    :text
#  birthday   :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  role_id    :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account do
    firstname "FName"
    lastname "LName"
    nickname "Memes"
    cellphone 1
    address "Text"
    birthday "2012-08-22"
    
    factory :adminaccount do
      firstname "FName"
      lastname "LName"
      role_id 1
    end

    factory :meaccount do
      firstname "Glenda"
      lastname "Bernardo"
      role_id 1
    end
    
    factory :client_non_member_account do
      firstname "Client Non Member"
      lastname "LName"
      role_id 2
    end

    factory :client_member_account do
      firstname "Client Member"
      lastname "LName"
      role_id 2
      after(:build) do |me|
        me.membership = FactoryGirl.build :family
      end
    end
    
    factory :therapist_account do
      firstname "Therapist Master"
      lastname "LName"
      role_id 3
    end
  end
end
