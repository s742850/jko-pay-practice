class Payment < ApplicationRecord
  #TODO validate
  validates_numericality_of :store_redeem_amount, :redeem_amount, :less_than_or_equal_to => 0
  validates_presence_of :merchant_id, :store_id, :merchant_trade_no, :pos_id, :trade_no, :trade_time, :payment_type, :trade_amount, :debit_amount, :available_amount
end
