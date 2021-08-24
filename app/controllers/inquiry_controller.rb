class InquiryController < ApplicationController

  before_action :validate_params!
  skip_before_action :verify_authenticity_token

  def inquiry
    # include?
    payment = Payment.find_by_merchant_trade_no(params[:merchant_trade_number])
    render json: { status_code: :Response::StatusCode::ERROR_ROW_NOT_FOUND } unless payment
    @request = ::JkoPay::Request::Pos::Inquiry.new
    @config = ::JkoPay::Request::Pos.config
    @config.merchant_id = params[:merchant_id]
    @config.merchant_key = params[:merchant_key]
    @request.configure @config

    @request.inquiry_type = params[:inquiry_type]
    @request.store_id = params[:store_id]
    @request.merchant_trade_number = params[:merchant_trade_number]
    @request.pos_id = params[:pos_id]
    @request.pos_trade_time = params[:pos_trade_time]

    @response = @request.request

    if @response.success?
      render json: { status_code: ::Response::StatusCode::SUCCESS, "response": @response }
    else
      render json: { status_code: ::Response::StatusCode::ERROR_JKO_API, "response": @response }
    end
  end
end
