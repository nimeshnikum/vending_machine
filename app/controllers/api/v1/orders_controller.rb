class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_api_user!, except: [:index, :show]

  def create
    response = OrderProcessing.new(current_user, order_params).call
    render json: response
  rescue OrderProcessing::InsufficientQuantityError, OrderProcessing::InsufficientDepositError => e
    render json: { error: e.message }, status: 400
  end

  private

  def order_params
    params.require(:order).permit(:product_id, :quantity)
  end
end
