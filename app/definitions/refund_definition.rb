RequestParamsValidation.define do
  action :create do
    request do
      required :merchant_id, type: :string, length: { max: 10 }
      required :merchant_key, type: :string
      required :store_id, type: :string, length: { max: 20 }
      required :store_name, type: :string, length: { max: 100 }
      required :merchant_trade_number, type: :string, length: { max: 60 }
      required :pos_id, type: :string, length: { max: 20 }
      required :pos_trade_time, type: :string, length: { max: 19 }
      required :trade_no, type: :string, length: { max: 25 }
      required :trade_amount, type: :integer
    end
  end
end


