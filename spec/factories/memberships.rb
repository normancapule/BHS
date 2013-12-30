# == Schema Information
#
# Table name: memberships
#
#  id          :integer          not null, primary key
#  account_id  :integer
#  card_number :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  member_type :integer
#

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
