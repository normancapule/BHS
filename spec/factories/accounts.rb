# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account do
    firstname "FName"
    lastname "LName"
    nickname "Memes"
    cellphone 1
    address "Text"
    birthday "2012-08-22"
    factory :member do
      association :membership, :strategy => :build
    end
  end
end
