class CategoriesController < ApplicationController
	def new 
		debugger
resposeObj = CONN.get "/LogicKart/rest/users/#{8}/edit"
@resposeObj = JSON.parse resposeObj.body

		# end_point_url = 'LogicKart/rest/users/8'
		# api_post_request(CONN,end_point_url,{"Content-Type"=> "application/json"},{}, {})
		@category = Category.new
	end

	def edit
		@category = Category.find(params[:id])
	end

	def index 
		@categories = Category.all
	end

	def update
		@category = Category.find(params[:id])
		if(@category.update(category_params))
			redirect_to categories_path
		else
			render 'edit'
		end
	end

	def create
		@category = Category.new(category_params)
		if @category.save
			redirect_to categories_path
		else 
			render 'new'
		end
	end

	def destroy
		@category = Category.find(params[:id])
		@category.destroy

		redirect_to categories_path
	end

	def show
		@category = Category.find(params[:id])
	end

	private
	def category_params
		params.require(:category).permit(:category_id, :category_name, :product_type)
	end
end
