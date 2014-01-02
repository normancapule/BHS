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

require 'spec_helper'

describe DataStream do
  pending "add some examples to (or delete) #{__FILE__}"
end
