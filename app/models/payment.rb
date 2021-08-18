class Payment < ApplicationRecord
  validates_numericality_of :store_redeem_amount, :redeem_amount, :less_than => 0
end
