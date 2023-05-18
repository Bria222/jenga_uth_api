class Api::V1::ProductsController < ApplicationController
  before_action :authorize_request, except: [:index, :categories]

  def index
    @products = Product.order('created_at desc').includes(:image_attachment)
    if @products
      render json: @products, status: :ok
    else
      render json: @products.errors.full_messages, status: :bad_request
    end
  end

  def show
    @product = Product.where(id: params[:id])
    if @product
      render json: @product, status: :ok
    else
      render json:'no product was found', status: 404
    end
  end

  def create
    if current_user.admin? || current_user.supplier?
      @product = Product.create(product_params)
      if @product.valid?
        render json: @product, status: 201
      else
        render json: { errors: @product.errors.full_messages }, status: 400
      end
    else 
      render json: { message: "Unauthorized" }, status: 401
    end
  end


  def destroy
    @product = Product.find_by_id(params[:id])
    if @product.destroy
       render json: 'product deleted successfully', status: 200
    else
       render json: 'unable to delete product check and try again', status: unprocessable_entity
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product .update(product_params)
      render json: 'product updated successfully'
    else
      render json: @product .errors.full_messages, status: :unprocessable_entity
    end
  end

  def categories
    @categories = Product.distinct.pluck(:category)
    render json: @categories, status: :ok
  end

private

def product_params
  params.permit(:name, :description, :price, :product_type, :discount, :units, :category, :image)
  # params.require(:product).permit(:name, :description, :price, :product_type, :discount, :units, :category, :image)
end

end
