# == Schema Information
#
# Table name: reservations
#
#  id            :integer          not null, primary key
#  number_people :integer
#  datetime      :datetime
#  name          :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reservation do
    number_people 1
    datetime DateTime.current
    name "MyString"
  end
end
