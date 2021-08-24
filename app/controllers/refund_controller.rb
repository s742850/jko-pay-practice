class RefundController < ApplicationController
  before_action :validate_params!
  skip_before_action :verify_authenticity_token

  def create
    @request = JkoPay::Request::Pos::Refund.new

    @config = ::JkoPay::Request::Pos.config
    @config.merchant_id = params[:merchant_id]
    @config.merchant_key = params[:merchant_key]
    @request.configure @config

    payment = Payment.find_by merchant_trade_no: params[:merchant_trade_number]
    unless payment.trade_no == params[:trade_no]
      render json: { status_code: ::Response::StatusCode::ERROR_REFUND_TRADE_NO }
    end

    @request.store_id = params[:store_id]
    @request.store_name = params[:store_name]
    @request.merchant_trade_number = params[:merchant_trade_number]
    @request.pos_id = params[:pos_id]
    @request.pos_trade_time = params[:pos_trade_time]
    @request.trade_number = params[:trade_no]
    @request.amount = params[:trade_amount]
    @request.un_redeem_amount = params[:un_redeem_amount]
    @response = @request.request

    if @response.success?
      refund = Refund.new
      refund.merchant
      refund.store_id

      if refund.save
        render json: { status_code: ::Response::StatusCode::SUCCESS }
      else
        render json: { status_code: ::Response::StatusCode::ERROR_DB }
      end
    else
      render json: { status_code: ::Response::StatusCode::ERROR_JKO_API, "response": @response }
    end
  end
end
