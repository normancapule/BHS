FactoryGirl.define do
  factory :user do
    username 'Test'
    role_id 1
    email 'test@example.com'
    password '123qwe'
    password_confirmation '123qwe'

    factory :admin do
      role_id 1
      account FactoryGirl.build :account
    end
    
    factory :clientnonmember do
      role_id 2
      account FactoryGirl.build :account
    end

    factory :clientmember do
      role_id 2
      account FactoryGirl.build :member
    end

    factory :therapist do
      role_id 3
      account FactoryGirl.build :account

    end
  end
end
