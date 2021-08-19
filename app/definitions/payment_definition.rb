RequestParamsValidation.define do
  action :create do
    request do
      required :merchant_id, type: :string, length: { max: 10 }
      required :merchant_key, type: :string
      required :merchant_trade_number, type: :string, length: { max: 60 }
      required :card_token, type: :string, length: { max: 18 }
      required :store_id, type: :string, length: { max: 20 }
      required :store_name, type: :string, length: { max: 100 }
      required :pos_id, type: :string, length: { max: 20 }
      required :pos_trade_time, type: :string, length: { max: 19 }
      required :trade_amount, type: :integer
      optional :un_redeem_amount, type: :integer
    end
  end
end


