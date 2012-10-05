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
