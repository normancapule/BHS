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

require 'spec_helper'

describe TransactionDetail do
  pending "add some examples to (or delete) #{__FILE__}"
end
