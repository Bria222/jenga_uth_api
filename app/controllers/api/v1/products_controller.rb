class Api::V1::ProductsController < ApplicationController
  before_action :authorize_request, except: [:index, :categories]

  def index
    @products = Product.order(created_at: :desc).includes(:product_images_attachments)
    render json: @products, status: :ok
    
  end

  def show
    @product = Product.find_by(id: params[:id])
    render json: @product.as_json(include: :product_images)
  end

  def create
    if current_user.admin? || current_user.supplier?
      @product = Product.new(product_params)
      if @product.save
        render json: @product, status: :created
      else
        render json: { errors: @product.errors.full_messages }, status: :bad_request
      end
    else 
      render json: { message: 'Unauthorized' }, status: :unauthorized
    end
  end

  def destroy
    @product = Product.find_by(id: params[:id])
    if @product
      @product.destroy
      render json: { message: 'Product deleted successfully' }, status: :ok
    else
      render json: { error: 'Product not found' }, status: :not_found
    end
  end

  def update
    @product = Product.find_by(id: params[:id])
    if @product
      if @product.update(product_params)
        render json: { message: 'Product updated successfully' }, status: :ok
      else
        render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Product not found' }, status: :not_found
    end
  end

  def categories
    @categories = Product.distinct.pluck(:category)
    render json: @categories, status: :ok
  end

  private

  def product_params
    params.permit(:name, :description, :price, :product_type, :discount, :units, :category_id, product_images: [])
  end
end
