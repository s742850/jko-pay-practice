RequestParamsValidation.define do
  #
  # action :show do
  #   request do
  #     required :id
  #   end
  # end

  action :create do
    request do
      required :merchant_id, type: :string, length: { max: 10 }
      required :name, type: :string, length: { max: 100 }
      required :pos_id, type: :string, length: { max: 20 }
    end
  end

  action :update do
    request do
      required :id
      optional :merchant_id, type: :string, length: { max: 10 }
      optional :store_id, type: :string, length: { max: 10 }
      optional :name, type: :string, length: { max: 100 }
      optional :pos_id, type: :string, length: { max: 20 }
    end
  end

  action :delete do
    request do
      required :id
    end
  end

end


