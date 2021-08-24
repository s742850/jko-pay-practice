require 'swagger_helper'

RSpec.describe 'api/payment', type: :request do

  path "/payment" do
    post "payment" do
      tags "Payment"
      consumes 'application/json'
      parameter name: :payment, in: :body, schema: {
        type: :object,
        properties: {
          merchant_id: { type: :string },
          merchant_key: { type: :string },
          card_token: { type: :string },
          store_id: { type: :string },
          store_name: { type: :string },
          merchant_trade_number: { type: :string },
          pos_id: { type: :string },
          pos_trade_time: { type: :string },
          trade_amount: { type: :integer },
          un_redeem_amount: { type: :integer }
        },
        required: ['merchant_id', 'merchant_key', 'card_token', 'store_id', 'store_name', 'merchant_trade_number', 'pos_id', 'pos_trade_time', 'trade_amount']
      }
      response "200", "payment response" do
        #noinspection RubyArgCount
        examples 'application/json' => {
          status_code: 0
        }
        run_test!
      end
    end
  end
end
