require 'swagger_helper'

RSpec.describe '測試', type: :request do

  path "/store" do
    get "Retrieves all stores" do
      tags "Stores"
      response "200", "store found" do
        # noinspection RubyArgCount
        examples 'application/json' => {
          status_code: 0,
          stores: [
            {
              "id": 1,
              "merchant_id": "123",
              "store_id": "123",
              "name": "123",
              "pos_id": "123",
              "created_at": "2021-08-20T22:47:53.517Z",
              "updated_at": "2021-08-20T22:47:53.517Z"
            },
            {
              "id": 2,
              "merchant_id": "33344",
              "store_id": "123",
              "name": "123",
              "pos_id": "123",
              "created_at": "2021-08-20T22:47:53.517Z",
              "updated_at": "2021-08-20T22:47:53.517Z"
            }
          ]
        }
        run_test!
      end
    end
  end

  path "/store/{id}" do
    get "Retrieves a store" do
      tags "Stores"
      parameter name: :id, in: :path, type: :string

      response "200", "store found" do
        #noinspection RubyArgCount
        examples 'application/json' => {
          id: 1,
          merchant_id: 'xxxx',
          name: 'weiby',
          pos_id: '22xxx',
        }
        run_test!
      end
    end

  end
end