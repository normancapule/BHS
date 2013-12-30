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

class Reservation < ActiveRecord::Base
  attr_accessible :name, :number_people, :datetime
  validates_presence_of :name, :number_people, :datetime
  
  def self.for_today(sort_column=nil, sort_direction=nil, date=nil)
    date = date ? DateTime.parse(date) : DateTime.current
    where("datetime between ? and ?", date.beginning_of_day, date.end_of_day).order("#{sort_column} #{sort_direction}")
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
