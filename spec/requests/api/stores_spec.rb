require 'swagger_helper'

RSpec.describe '測試', type: :request do

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