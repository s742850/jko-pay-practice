# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/refund', type: :request do
  path '/refund' do
    post '退款' do
      tags 'Refund'
      consumes 'application/json'
      parameter name: :refund, in: :body, schema: {
        type: :object,
        properties: {
          merchant_trade_number: { type: :string, description: '商店端交易序號(退款流水號),需為唯一值，不可重複', example: '1234555555' },
          merchant_id: { type: :string, description: '特店代碼', example: '9999999' },
          merchant_key: { type: :string, example: '2AA6B9B6F9C64247ABB2677B6AF2C896' },
          store_id: { type: :string, description: '商店編號', example: '1234' },
          store_name: { type: :string, description: '商店名稱', example: '街口測試' },
          pos_id: { type: :string, description: 'POS機號', example: '1' },
          pos_trade_time: { type: :string, description: 'POS 端交易日期時間, 格式:yyyy/MM/dd HH:mm:ss',
                            example: '2020/08/01 10:05:11' },
          trade_no: { type: :string, description: '原街口端交易序號, POS 端需比對客戶退款單號是否正確', example: 'J0065220121081800001' },
          trade_amount: { type: :integer, description: '退款金額', example: 10 }
        },
        required: %w[merchant_trade_number merchant_id merchant_key store_id store_name
                     pos_id pos_trade_time trade_amount ]
      }
      response '200', 'payment response' do
        # noinspection RubyArgCount
        examples 'application/json' => {
          status_code: 0
        }
        run_test!
      end
    end
  end
end
