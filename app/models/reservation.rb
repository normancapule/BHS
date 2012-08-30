class Reservation < ActiveRecord::Base
  attr_accessible :name, :number_people, :datetime
  validates_presence_of :name, :number_people, :datetime
  
  def self.for_today
    where("datetime between ? and ?", DateTime.current.beginning_of_day, DateTime.current.end_of_day).sort_by {|x| x.datetime}
  end

  def formatted_time
    datetime.strftime "%p %I:%M"
  end

  def hour_12
    datetime.strftime "%I"
  end

  def minute
    datetime.strftime "%M"
  end

  def am_pm
    datetime.strftime("%p").upcase
  end
end
