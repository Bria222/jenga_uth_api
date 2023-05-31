class ProductSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :description, :price, :product_type, :discount, :units, :category_id, :product_images

  def product_images
    object.product_images.map { |image| url_for(image) if image.blob.present? }
  end
end
