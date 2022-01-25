class Api::V1::UsersController < ApplicationController
  before_action :authenticate_api_user!, except: [:index, :show]

  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User does not exist' }, status: 400
  end

  def update
    @user = User.find(params[:id])
    role_id = Role.find_by(name: params[:user][:role]).id
    user_params.delete(:role)
    user_params[:role_ids] = role_id

    if @user && (@user == current_user) && @user.update!(user_params.merge!(role_ids: role_id))
      render json: @user
    else
      render json: { error: 'Unable to update a user' }, status: 400
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user && (@user == current_user) && @user.destroy
      render json: { message: 'User successfully deleted' }, status: 200
    else
      render json: { error: 'Unable to delete a product' }, status: 400
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User does not exist' }, status: 400
  end

  private

  def user_params
    params.require(:user).permit(:uid, :name, :role, :role_ids)
  end
end
