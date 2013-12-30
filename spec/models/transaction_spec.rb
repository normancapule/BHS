# == Schema Information
#
# Table name: transactions
#
#  id               :integer          not null, primary key
#  customer_id      :integer
#  total_price      :float            default(0.0)
#  therapist_id     :integer
#  notes            :text
#  paid             :boolean          default(FALSE)
#  transaction_type :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  transac_date     :date
#

require 'spec_helper'

describe Transaction do
  pending "add some examples to (or delete) #{__FILE__}"
end
