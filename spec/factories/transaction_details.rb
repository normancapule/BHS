# == Schema Information
#
# Table name: transaction_details
#
#  id             :integer          not null, primary key
#  transaction_id :integer
#  service_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction_detail do
    transaction_id 1
    service_id 1
    price_type 1
  end
end
