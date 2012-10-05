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
      association :membership, :strategy => :build
    end
    
    factory :therapist_account do
      firstname "Therapist Master"
      lastname "LName"
      role_id 3
    end
  end
end
