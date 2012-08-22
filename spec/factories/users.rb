FactoryGirl.define do
  factory :user do
    username 'Test'
    role_id 1
    account_id 1
    email 'test@example.com'
    password '123qwe'
    password_confirmation '123qwe'
    
    factory :admin do
      role_id 1
      account 1
    end
    
    factory :client do
      role_id 2
      account 2
    end
  end
end
