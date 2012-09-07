# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#admin
  FactoryGirl.create :me
  FactoryGirl.create :admin

#customers
  FactoryGirl.create :client_non_member_account
  client = FactoryGirl.build :client_member_account
  client.membership = FactoryGirl.build :personalized
  client.save

#therapist
  FactoryGirl.create :therapist_account
