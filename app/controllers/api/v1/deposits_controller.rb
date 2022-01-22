class Api::V1::DepositsController < ApplicationController
  before_action :authenticate_api_user!, except: [:index, :show]

  def create
    if current_user.add_deposit!(deposit_params[:deposit].to_i)
      render json: current_user
    else
      render json: { error: 'Unable to deposit' }, status: 400
    end
  end

  def reset
    current_user.reset_deposit!
    render json: current_user
  end

  private

  def deposit_params
    params.require(:user).permit(:deposit)
  end
end
