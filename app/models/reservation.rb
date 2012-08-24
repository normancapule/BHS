class Reservation < ActiveRecord::Base
  attr_accessible :name, :number_people, :datetime
  validates_presence_of :name, :number_people, :datetime
  
  def self.for_today
    where("datetime between ? and ?", DateTime.current.beginning_of_day, DateTime.current.end_of_day)
  end
end
