class CancelController < ApplicationController
  def create
    payment = Payment.find_by_merchant_trade_no(params[:merchant_trade_number])
    unless payment
      render :json => { status_code: :Response::StatusCode::ERROR_ROW_NOT_FOUND }
    end

    @request = JkoPay::Request::Pos::Cancel.new
    @config = ::JkoPay::Request::Pos.config
    @config.merchant_id = params[:merchant_id]
    @config.merchant_key = params[:merchant_key]
    @request.configure @config

    @request.store_id = payment.store_id
    @request.store_name = payment.store_name
    @request.merchant_trade_number = payment.merchant_trade_no
    @request.pos_id = payment.pos_id
    @request.pos_trade_time = payment.pos_trade_time
    @request.card_token = payment.card_token
    @request.amount = payment.trade_amount
    @request.un_redeem_amount = payment.un_redeem_amount
    @request.extra1 = params[:extra1]
    @request.extra2 = params[:extra2]
    @request.extra3 = params[:extra3]
    @response = @request.request

    if @response.success?
      cancel = Cancel.new
      cancel.merchant_id = payment.merchant_id
      cancel.store_id = payment.store_id
      cancel.merchant_trade_no = payment.merchant_trade_no
      cancel.pos_id = payment.pos_id
      cancel.trade_amount = payment.trade_amount
      render :json => { status_code: ::Response::StatusCode::SUCCESS }
    else
      render :json => { status_code: ::Response::StatusCode::ERROR_JKO_API, "response": @response }
    end
  end
end
