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
    render json: { error: 'Product does not exist' }, status: 404
  end

  def create
    @product = current_user.products.build(product_params)
    authorize @product

    @product.save!
    render json: @product
  end

  def update
    @product = current_user.products.find(params[:id])
    authorize @product

    @product && @product.update!(product_params)
    render json: @product
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Product does not exist or is readonly!' }, status: 404
  end

  def destroy
    @product = current_user.products.find(params[:id])
    authorize @product

    @product && @product.destroy!
    render json: { message: 'Product successfully deleted' }, status: 200
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Product does not exist or is readonly!' }, status: 404
  end

  private

  def product_params
    params.require(:product).permit(:name, :quantity, :cost)
  end
end
