FactoryGirl.define do
  factory :user do
    password '123qwe'
    password_confirmation '123qwe'

    factory :admin do
      username 'admin'
      email 'admin@example.com'
      role_id 1
      account FactoryGirl.build :account
    end
    
    factory :clientnonmember do
      username 'clientnonmember'
      email 'cnm@example.com'
      role_id 2
      account FactoryGirl.build :account
    end

    factory :clientmember do
      username 'clientmember'
      email 'cm@example.com'
      role_id 2
      account FactoryGirl.build :member
    end

    factory :therapist do
      username 'therapist'
      email 'tp@example.com'
      role_id 3
      account FactoryGirl.build :account
    end
  end
end
