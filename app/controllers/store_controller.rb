class StoreController < ApplicationController

  before_action :validate_params!
  skip_before_action :verify_authenticity_token

  def index
    render_success(Store.all)
  end

  def create
    store = Store.new
    store.valid?
    assign_params(store)
    store_save_and_response(store)
  end

  def show
    store = Store.find_by_id(params[:id])
    render_error_row_not_found and return unless store

    render_success(store)
  end

  def update
    store = Store.find_by_id(params[:id])
    render_error_row_not_found and return unless store

    assign_params(store)
    store_save_and_response(store)
  end

  def destroy
    store = Store.find_by_id(params[:id])
    render_error_row_not_found and return unless store

    render json: { status_code: ::Response::StatusCode::SUCCESS } if store.delete
  end

  private

  def render_success(store)
    render json: { status_code: ::Response::StatusCode::SUCCESS, stores: store }
  end

  def render_error_row_not_found
    render json: { status_code: ::Response::StatusCode::ERROR_ROW_NOT_FOUND }
  end

  def store_save_and_response(store)
    if store.save
      render_success store
    else
      render json: { status_code: ::Response::StatusCode::ERROR_DB }
    end
  end

  def assign_params(store)
    store.merchant_id = params[:merchant_id] if params[:merchant_id]
    store.name = params[:name] if params[:name]
    store.pos_id = params[:pos_id] if params[:pos_id]
  end

end
