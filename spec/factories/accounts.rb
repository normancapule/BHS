# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account do
    name "MyString"
    nickname "MyString"
    cellphone 1
    address "MyText"
    birthday "2012-08-22"
    membership_id 1
  end
end
