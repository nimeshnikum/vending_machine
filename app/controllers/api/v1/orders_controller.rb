class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_api_user!, except: [:index, :show]

  def create

  end
end
