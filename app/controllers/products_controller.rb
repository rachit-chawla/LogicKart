class ProductsController < ApplicationController
	def new
		@product = Product.new
		@category = Category.find(params[:category_id])
	end

	def index
		@category = Category.find(params[:category_id])
		@category_products = @category.products
	end

	def create
		@category = Category.find(params[:category_id])
		@product = @category.products.new(product_params)
		if @product.save
			redirect_to category_products_path
		else
			render 'new'
		end
	end

	private
	  def product_params
		params.require(:product).permit(:product_id, :category_id, :product_name, :product_price)
	  end
end