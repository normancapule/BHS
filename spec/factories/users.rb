FactoryGirl.define do
  factory :user do
    password '123qwe'
    password_confirmation '123qwe'

    factory :me do
      username 'jcapule'
      email 'jcapule@exist.com'
      account FactoryGirl.build :adminaccount
    end
    
    factory :admin do
      username 'admin'
      email 'admin@example.com'
      account FactoryGirl.build :adminaccount
    end
    
    factory :testadmin do
      username 'admin'
      email 'admin@example.com'
      account FactoryGirl.build :adminaccount
    end

    factory :clientnonmember do
      username 'clientnonmember'
      email 'cnm@example.com'
      account FactoryGirl.build :client_non_member_account
    end

    factory :clientmember do
      username 'clientmember'
      email 'cm@example.com'
      account FactoryGirl.build :client_member_account
    end

    factory :therapist do
      username 'therapist'
      email 'tp@example.com'
      account FactoryGirl.build :therapist_account
    end

    trait :user_t2 do
      account FactoryGirl.build :therapist_account, :t3
    end

    trait :user_cnm2 do
      account FactoryGirl.build :client_non_member_account, :cnm3
    end
  end
end
