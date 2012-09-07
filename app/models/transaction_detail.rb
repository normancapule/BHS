class TransactionDetail < ActiveRecord::Base
  attr_accessible :service_id, :transaction_id

  belongs_to :service
  belongs_to :transaction
end
