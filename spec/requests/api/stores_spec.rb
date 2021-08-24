require 'swagger_helper'

RSpec.describe '商店', type: :request do

  path '/store' do
    get 'Retrieves all stores' do
      tags 'Stores'
      response '200', 'store found' do
        # noinspection RubyArgCount
        examples 'application/json' => {
          status_code: 0,
          stores: [
            {
              "id": 1,
              "merchant_id": '9999999',
              "store_id": '1',
              "name": '街口測試1',
              "pos_id": '1',
              "created_at": '2021-08-20T22:47:53.517Z',
              "updated_at": '2021-08-20T22:47:53.517Z'
            },
            {
              "id": 2,
              "merchant_id": '9999999',
              "store_id": '2',
              "name": '街口測試2',
              "pos_id": '2',
              "created_at": '2021-08-21T22:47:53.517Z',
              "updated_at": '2021-08-21T22:47:53.517Z'
            }
          ]
        }
        run_test!
      end
    end
  end

  path '/store/{id}' do
    get 'Retrieves a store' do
      tags 'Stores'
      parameter name: :id, in: :path, type: :string, description: :'商店ID流水號', example: "1"

      response '200', 'store found' do
        #noinspection RubyArgCount
        examples 'application/json' => {
          status_code: 0,
          "store": {
            "id": 1,
            "merchant_id": '9999999',
            "name": '街口測試1',
            "pos_id": '1',
            "created_at": '2021-08-20T22:47:53.517Z',
            "updated_at": '2021-08-20T22:47:53.517Z'
          }
        }
        run_test!
      end
    end

    patch 'Update a store' do
      tags 'Stores'

      consumes 'application/json'
      parameter name: :id, in: :path, type: :string, description: :'商店ID流水號', example: "1"
      parameter name: :store, in: :body, schema: {
        type: :object,
        properties: {
          merchant_id: { type: :string, example: '9999999', description: :'特店代碼' },
          name: { type: :string, example: '拉亞漢堡' },
          pos_id: { type: :string, example: '1', description: :'POS機號' }
        }
      }

      response '200', 'update store' do
        #noinspection RubyArgCount
        examples 'application/json' => {
          status_code: 0,
          "store": {
            "id": 1,
            "merchant_id": '9999999',
            "name": '街口測試1',
            "pos_id": '1',
            "created_at": '2021-08-20T22:47:53.517Z',
            "updated_at": '2021-08-20T22:47:53.517Z'
          }
        }
        run_test!
      end
    end

    delete 'Delete a store' do
      tags 'Stores'
      parameter name: :id, in: :path, type: :string, description: :'商店ID流水號', example: "1"
      response '200', 'delete store' do
        #noinspection RubyArgCount
        examples 'application/json' => {
          status_code: 0
        }
        run_test!
      end
    end
  end

  path '/store' do
    post 'Create a store' do
      tags 'Stores'
      consumes 'application/json'
      parameter name: :store, in: :body, schema: {
        type: :object,
        properties: {
          merchant_id: { type: :string, example: '9999999', description: :'特店代碼' },
          name: { type: :string, example: '拉亞漢堡' },
          pos_id: { type: :string, example: '1', description: :'POS機號' }
        },
        required: ['merchant_id', 'name', 'pos_id']
      }
      response '200', 'store created' do
        #noinspection RubyArgCount
        examples 'application/json' => {
          status_code: 0,
          "store": {
            "id": 1,
            "merchant_id": '9999999',
            "name": '街口測試1',
            "pos_id": '1',
            "created_at": '2021-08-20T22:47:53.517Z',
            "updated_at": '2021-08-20T22:47:53.517Z'
          }
        }
        run_test!
      end
    end
  end
end