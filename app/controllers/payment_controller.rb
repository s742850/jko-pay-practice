require 'jko_pay/request/pos/pay'
require 'jko_pay/config'
require 'jko_pay/response/pos/pay'

class PaymentController < ApplicationController

  skip_before_action :verify_authenticity_token

  # @@config.merchant_id = "9999999"
  # @@config.merchant_key = "2AA6B9B6F9C64247ABB2677B6AF2C896"

  # 測試用的
  # def index
  #   @request = JkoPay::Request::Pos::Pay.new
  #   @request.configure @config
  #   @request.card_token = "22C333334444455555"
  #   @request.store_id = "9999999"
  #   @request.store_name = "街口Test"
  #   @request.merchant_trade_number = "20200090444511"
  #   @request.pos_id = 1
  #   @request.pos_trade_time = "2021/08/01 10:05:11"
  #   @request.amount = 10
  #   @request.un_redeem_amount = 0
  #   @response = @request.request
  #   if @response.success?
  #   else
  #     @response.message
  #   end
  # end

  def create
    @request = JkoPay::Request::Pos::Pay.new

    @config = JkoPay::Config.new
    @config.api_host = "https://uat-pos.jkopay.app/Test"
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
    # return render :json => { "config": @config }
    @response = @request.request
    render :json => { "response": @response }

    if @response.success?
      #TODO Persistence
      @payment = Payment.new
      @payment.merchant_id = @response.merchant_id
      @payment.store_id = @response.store_id
      @payment.gateway_trade_no = @response.gateway_trade_number
      @payment.pos_id = @response.pos_id
      @payment.trade_no = @response.trade_number
      @payment.trade_time = @response.trade_time
      @payment.payment_type = @response.payment_type
      @payment.trade_amount = @response.amount
      @payment.debit_amount = @response.debit_amount
      @payment.redeem_name = @response.redeem_name
      @payment.redeem_amount = @response.redeem_amount
      @payment.store_redeem_amount = @response.store_redeem_amount
      @payment.available_amount = @response.available_amount
      @payment.invoice_vehicle = @response.carrier
      @payment.mer_mem_token = @response.member_token
      @payment.remark = @response.note
      @payment.extra1 = @response.extra_info1
      @payment.extra2 = @response.extra_info2
      @payment.extra3 = @response.credit_card_info

      # if @payment.save
      #   render :json => { status: 0 }
      # else
      #   render :json => { status: 100 }
      # end

    else
      render :json => { "response": @response }
    end

  end
end
