class Api::V1::DepositsController < ApplicationController
  before_action :authenticate_api_user!, except: [:index, :show]

  def create
    @deposit = current_user.deposits.build(deposit_params)
    if @deposit.save
      render json: @deposit
    else
      render json: { error: 'Unable to deposit' }, status: 400
    end
  end

  def reset
    Deposit.reset!(current_user.deposits.active)
    render json: current_user
  end

  private

  def deposit_params
    params.require(:deposit).permit(:amount)
  end
end
