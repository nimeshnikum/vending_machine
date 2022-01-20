class Api::V1::ProductsController < ApplicationController
  before_action :authenticate_api_user!, except: [:index, :show]

  def index
    @products = Product.all
    render json: @products
  end

  def show
    @product = Product.find(params[:id])
    render json: @product
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Unable to find a product' }, status: 400
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      render json: @product
    else
      render json: { error: 'Unable to create a product' }, status: 400
    end
  end

  def update
    @product = current_user.products.find(params[:id])
    if @product && @product.update(product_params)
      render json: @product
    else
      render json: { error: 'Unable to update a product' }, status: 400
    end
  end

  def destroy
    @product = current_user.products.find(params[:id])
    if @product && @product.destroy
      render json: { message: 'Product successfully deleted' }, status: 200
    else
      render json: { error: 'Unable to delete a product' }, status: 400
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :quantity, :cost)
  end
end
