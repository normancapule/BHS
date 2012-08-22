class Reservation < ActiveRecord::Base
  attr_accessible :name, :number_people, :datetime
  validates_presence_of :name, :number_people, :datetime
  validate :datetime_checker, :if => "!datetime.nil?"

  def datetime_checker
    begin
      DateTime.parse datetime.to_s
      true
    rescue
      self.errors[:datetime] << "Reservation datetime is incorrect"
      false
    end
  end
end
