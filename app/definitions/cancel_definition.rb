RequestParamsValidation.define do
  action :create do
    request do
      required :merchant_id, type: :string, length: { max: 10 }
      required :merchant_key, type: :string
    end
  end
end


