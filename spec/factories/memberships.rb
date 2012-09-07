# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :membership do
    card_number 124124
    
    factory :personalized do
      member_type 1
    end

    factory :family do
      member_type 2
    end

    factory :child do
      member_type 3
    end
  end
end
