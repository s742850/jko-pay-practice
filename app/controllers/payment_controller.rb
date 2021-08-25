require 'jko_pay/request/pos/pay'
require 'jko_pay/config'
require 'jko_pay/response/pos/pay'

class PaymentController < ApplicationController

  before_action :validate_params!
  skip_before_action :verify_authenticity_token

  def create
    @request = JkoPay::Request::Pos::Pay.new

    @config = ::JkoPay::Request::Pos.config
    @config.merchant_id = params[:merchant_id]
    @config.merchant_key = params[:merchant_key]
    @request.configure @config

    @request.card_token = params[:card_token]
    @request.store_id = params[:store_id]
    @request.store_name = params[:store_name]
    @request.merchant_trade_number = params[:merchant_trade_number]
    @request.pos_id = params[:pos_id]
    @request.pos_trade_time = params[:pos_trade_time]
    @request.amount = params[:trade_amount]
    @request.un_redeem_amount = params[:un_redeem_amount]
    @response = @request.request

    if @response.success?
      payment = Payment.new
      unless @response.is_trade_repeat?
        payment.merchant_id = @response.merchant_id
        payment.merchant_trade_no = @response.merchant_trade_number
        payment.store_id = @response.store_id
        payment.gateway_trade_no = @response.gateway_trade_number
        payment.pos_id = @response.pos_id
        payment.trade_no = @response.trade_number
        payment.trade_time = @response.trade_time
        payment.payment_type = @response.payment_type
        payment.trade_amount = @response.amount
        payment.debit_amount = @response.debit_amount
        payment.redeem_name = @response.redeem_name
        payment.redeem_amount = @response.redeem_amount
        payment.store_redeem_amount = @response.store_redeem_amount.to_i
        payment.available_amount = @response.available_amount
        payment.invoice_vehicle = @response.carrier
        payment.mer_mem_token = @response.member_token
        payment.remark  = @response.note
        payment.extra1 = @response.extra_info1
        payment.extra2 = @response.extra_info2
        payment.extra3 = @response.credit_card_info
        if payment.save
          render json: { status_code: ::Response::StatusCode::SUCCESS }
        else
          render json: { status_code: ::Response::StatusCode::ERROR_DB_SAVE, message: payment.errors }
        end
      end
    else
      render json: { status_code:  ::Response::StatusCode::ERROR_JKO_API, "response": @response }
    end

  end
end
