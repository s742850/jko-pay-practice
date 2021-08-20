class StoreController < ApplicationController

  before_action :validate_params!
  skip_before_action :verify_authenticity_token

  def index
    render :json => { status_code: ::Response::StatusCode::SUCCESS, stores: Store.all }
  end

  def create
    store = Store.new
    store.valid?
    assignParams(store)
    store_save_and_response(store)
  end

  def show
    # catch or find_by
    store_find = Store.find_by_id(params[:id])
    if store_find
      render :json => { status_code: ::Response::StatusCode::SUCCESS, stores: store_find }
    else
      render :json => { status_code: ::Response::StatusCode::ERROR_ROW_NOT_FOUND }
    end
  end

  def update
    store_find = Store.find(params[:id])
    assignParams(store_find)
    store_save_and_response(store_find)
  end

  def delete
    store_find = Store.find(params[:id])
    render :json => { status_code: ::Response::StatusCode::SUCCESS } if store_find.delete
  end

  private

  def store_save_and_response(store)
    if store.save
      render :json => { status_code: ::Response::StatusCode::SUCCESS }
    else
      render :json => { status_code: ::Response::StatusCode::ERROR_DB }
    end
  end

  def assignParams(store)
    store.merchant_id = params[:merchant_id] if params[:merchant_id]
    store.store_id = params[:store_id] if params[:store_id]
    store.nstore_idame = params[:name] if params[:name]
    store.pos_id = params[:pos_id] if params[:pos_id]
  end

end
