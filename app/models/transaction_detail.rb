class TransactionDetail < ActiveRecord::Base
  attr_accessible :price_type, :service_id, :transaction_id

  belongs_to :service
  belongs_to :transaction

  def self.price_types
    {}
  end
end
