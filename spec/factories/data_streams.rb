# == Schema Information
#
# Table name: data_streams
#
#  id           :integer          not null, primary key
#  client_count :integer
#  stream_date  :date
#  gross        :decimal(8, 2)
#  net          :decimal(8, 2)
#  expenses     :decimal(8, 2)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :data_stream do
  end
end
