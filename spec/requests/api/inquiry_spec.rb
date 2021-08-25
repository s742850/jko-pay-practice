require 'swagger_helper'

RSpec.describe 'api/inquiry', type: :request do
  path '/inquiry' do
    post '付款查詢或退款查詢' do
      tags 'Inquiry'
      consumes 'application/json'
      parameter name: :inquiry, in: :body, schema: {
        type: :object,
        properties: {
          merchant_trade_number: { type: :string, description: '商店端交易序號(付款流水號)', example: '1234555555' },
          merchant_id: { type: :string, description: '特店代碼', example: '9999999' },
          merchant_key: { type: :string, example: '2AA6B9B6F9C64247ABB2677B6AF2C896' },
          inquiry_type: { type: :string, description: '付款查詢請帶"P" 退款查詢請帶"R"', example: 'R' },
          store_id: { type: :string, description: '商店編號', example: '1234' },
          pos_id: { type: :string, description: 'POS機號', example: '1' },
          pos_trade_time: { type: :string, description: 'POS 端交易日期時間, 格式:yyyy/MM/dd HH:mm:ss', example: '2020/08/01 10:05:11' },
        },
        required: %w[merchant_trade_number merchant_id merchant_key inquiry_type store_id pos_id pos_trade_time]
      }
      response '200', 'inquiry response' do
        #noinspection RubyArgCount
        examples 'application/json' => {
          "status_code": 2,
          "response": {
            "raw": {
              "status": 200,
              "body": "{\"MerchantID\":\"9999999\",\"StoreID\":\"1234\",\"GatewayTradeNo\":\"\",\"MerchantTradeNo\":\"1234555555\",\"PosID\":\"1\",\"StatusCode\":\"916\",\"StatusDesc\":\"查無此訂單\"}",
              "response_headers": {
                "server": "nginx/1.18.0",
                "date": "Tue, 24 Aug 2021 10:03:20 GMT",
                "content-type": "application/json",
                "transfer-encoding": "chunked",
                "connection": "keep-alive"
              }
            },
            "MerchantID": "9999999",
            "StoreID": "1234",
            "GatewayTradeNo": "",
            "MerchantTradeNo": "1234555555",
            "PosID": "1",
            "StatusCode": "916",
            "StatusDesc": "查無此訂單"
          }
        }
        run_test!
      end
    end
  end
end
