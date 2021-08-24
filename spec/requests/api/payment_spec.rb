require 'swagger_helper'

RSpec.describe 'api/payment', type: :request do

  path '/payment' do
    post 'payment' do
      tags 'Payment'
      consumes 'application/json'
      parameter name: :payment, in: :body, schema: {
        type: :object,
        properties: {
          merchant_id: { type: :string, description: '特店代碼', example: '9999999' },
          merchant_key: { type: :string, example: '2AA6B9B6F9C64247ABB2677B6AF2C896' },
          card_token: { type: :string, description: '支付條碼', example: '22C333334444455555' },
          store_id: { type: :string, description: '商店編號', example: '1234' },
          store_name: { type: :string, description: '商店名稱', example: '街口測試' },
          merchant_trade_number: { type: :string, description: '商店端交易序號(付款流水號)', example: '1234555555' },
          pos_id: { type: :string, description: 'POS機號', example: '1' },
          pos_trade_time: { type: :string, description: 'POS 端交易日期時間, 格式:yyyy/MM/dd HH:mm:ss', example: '2020/08/01 10:05:11' },
          trade_amount: { type: :integer, description: '實際消費金額', example: 10 },
          un_redeem_amount: { type: :integer, description: '不可折抵金額, 若無請放 0', example: 0 }
        },
        required: %w[merchant_id merchant_key card_token store_id store_name merchant_trade_number
                     pos_id pos_trade_time trade_amount un_redeem_amount]
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
