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
#

require 'spec_helper'

describe Service do
  it "should get all kinds of types" do
    Service.types
  end
end
