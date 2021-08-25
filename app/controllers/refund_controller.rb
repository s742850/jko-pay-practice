class RefundController < ApplicationController
  before_action :validate_params!
  skip_before_action :verify_authenticity_token

  def create
    payment = Payment.find_by merchant_trade_no: params[:merchant_trade_number]
    render_row_not_found and return unless payment

    unless payment.trade_no == params[:trade_no]
      render json: { status_code: ::Response::StatusCode::ERROR_REFUND_TRADE_NO }
      return
    end

    @request = JkoPay::Request::Pos::Refund.new
    @config = ::JkoPay::Request::Pos.config
    @config.merchant_id = params[:merchant_id]
    @config.merchant_key = params[:merchant_key]
    @request.configure @config
    @request.store_id = params[:store_id]
    @request.store_name = params[:store_name]
    @request.merchant_trade_number = params[:merchant_trade_number]
    @request.pos_id = params[:pos_id]
    @request.pos_trade_time = params[:pos_trade_time]
    @request.trade_number = params[:trade_no]
    @request.amount = params[:trade_amount]
    @response = @request.request
    render_success and return if @response.is_trade_repeat?

    if @response.success?
      refund = Refund.new
      refund.merchant_id = @response.merchant_id
      refund.store_id = @response.store_id
      refund.gateway_trade_no = @response.gateway_trade_number
      refund.pos_id = @response.pos_id
      refund.trade_no = @response.trade_number
      refund.debit_amount = @response.debit_amount
      refund.available_amount = @response.available_amount
      refund.trade_no = @response.trade_number
      refund.refund_trade_time = @response.refund_trade_time

      begin
        if refund.save
          render_success
        else
          render json: { status_code: ::Response::StatusCode::ERROR_DB_SAVE }
        end
      rescue ActiveRecord::RecordNotUnique
        render json: { status_code: ::Response::StatusCode::ERROR_DUPLICATE_ROW }
      end
    else
      render json: { status_code: ::Response::StatusCode::ERROR_JKO_API, "response": @response }
    end
  end

  private

  def render_success
    render json: { status_code: ::Response::StatusCode::SUCCESS }
  end

  def render_row_not_found
    render json: { status_code: ::Response::StatusCode::ERROR_ROW_NOT_FOUND }
  end
end
