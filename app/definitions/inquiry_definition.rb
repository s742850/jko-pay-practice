RequestParamsValidation.define do
  action :create do
    request do
      required :inquiry_type, type: :string, length: { max: 1 }, validate: lambda { |value| ["R", "P"].include?(value) }
      required :merchant_id, type: :string, length: { max: 10 }
      required :merchant_key, type: :string
      required :merchant_trade_number, type: :string, length: { max: 60 }
      required :store_id, type: :string, length: { max: 20 }
      required :pos_id, type: :string, length: { max: 20 }
      required :pos_trade_time, type: :string, length: { max: 19 }
    end
  end
end


