require 'swagger_helper'

RSpec.describe 'api/cancel', type: :request do
  path '/cancel' do
    post '取消,當POS端送出付款交易(Payment)後，與街口連線異常或交易逾時，可發送取消交易(Cancel)，取消該筆付款。' do
      tags 'Cancel'
      consumes 'application/json'
      parameter name: :payment, in: :body, schema: {
        type: :object,
        properties: {
          merchant_trade_number: { type: :string, description: '商店端交易序號(付款流水號)(需與 Payment 相同)', example: '20200090444511' },
          merchant_id: { type: :string, description: '特店代碼', example: '9999999' },
          merchant_key: { type: :string, example: '2AA6B9B6F9C64247ABB2677B6AF2C896' }
        },
        required: %w[merchant_id merchant_key]
      }
      response '200', 'payment response' do
        #noinspection RubyArgCount
        examples 'application/json' => {
          status_code: 0
        }
        run_test!
      end
    end
  end

end
