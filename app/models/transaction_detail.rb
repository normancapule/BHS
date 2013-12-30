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

class TransactionDetail < ActiveRecord::Base
  attr_accessible :service_id, :transaction_id

  belongs_to :service
  belongs_to :transaction
end
