# == Schema Information
#
# Table name: services
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  service_type_id   :integer
#  member_price_morn :float            default(0.0)
#  member_price_eve  :float            default(0.0)
#  regular_price     :float            default(0.0)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  mytype            :string(255)      default("service")
#  service_id        :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :service do
    name "Service For All"
    service_type_id 1
    member_price_morn 1.0
    member_price_eve 1.1
    regular_price 2.0
  end

  trait :s2 do
    name "Service for All 2"
  end
  
  trait :s3 do
    name "Service for All 3"
  end
end
