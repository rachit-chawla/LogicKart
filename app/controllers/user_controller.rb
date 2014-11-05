class UserController < ApplicationController
	before_action :new_body_params, only: [:user_change_password, :update]
	before_action :authorized_user, only: [:login, :sign_up]
	before_action :unauthorized_user, only: [:index, :change_password, :log_out, :show]
	$resp = nil
	def new
		
	# 	@user = User.new
	end

	def create
		# @user = User.new[user_params]
		# if @user.save
		# 	redirect_to 
		# end
	end

	def show
		respose = CONN.post do |req|
		  req.url "/LogicKart/rest/users/#{session[:current_user]["id"]}/view"
		  req.headers['Content-Type'] = 'application/json'
		  req.body = auth_Token
		end
		@resposeObj = JSON.parse respose.body
		$resp = JSON.parse respose.body
		if(!@resposeObj["errorMessage"].blank?)
			if(@resposeObj["errorMessage"] == "Session Expired!")
				redirect_to login_path
			else
				flash[:notice] = @resposeObj["errorMessage"]
				redirect_to user_index_path
			end
		end
	end

	def edit
		respose = CONN.post do |req|
		  req.url "/LogicKart/rest/users/#{session[:current_user]["id"]}/view"
		  req.headers['Content-Type'] = 'application/json'
		  req.body = auth_Token
		end
		@resposeObj = JSON.parse respose.body
		$resp = JSON.parse respose.body
		if(!@resposeObj["errorMessage"].blank?)
			if(@resposeObj["errorMessage"] == "Session Expired!")
				session[:current_user] = nil
				redirect_to login_path
			else
				flash[:notice] = @resposeObj["errorMessage"]
				redirect_to user_index_path
			end
		end
	end

	def update
		respose = CONN.post do |req|
		  req.url "/LogicKart/rest/users/#{session[:current_user]["id"]}/update"
		  req.headers['Content-Type'] = 'application/json'
		  req.body = @new_params
		end
		@resposeObj = JSON.parse respose.body
		if(@resposeObj["errorMessage"].blank?)
			flash[:notice] = @resposeObj["successMesage"]
		 	redirect_to user_index_path
		else
			flash[:notice] = @resposeObj["errorMessage"]
		 	# render 'forgot_password'
		 	redirect_to :back
		 end
	end

	def index
	end

	def delete
	end

	def login

	end

	def user_login
		respose = CONN.post do |req|
		  req.url '/LogicKart/rest/login/'
		  req.headers['Content-Type'] = 'application/json'
		  req.body = params["User"]
		end
		@resposeObj = JSON.parse respose.body
		if(@resposeObj["errorMessage"].blank?)
			session[:current_user] = @resposeObj
			$resp = JSON.parse respose.body
			if(@resposeObj["type"] == "user")
				flash[:notice] = "Welcome " + @resposeObj["fname"] + " to LogicKart"
				 redirect_to user_index_path
			else
				flash[:notice] = "Welcome "+ @resposeObj["fname"] + " to LogicKart"
				 redirect_to admin_index_path
			end
		else
			flash[:notice] = @resposeObj["errorMessage"]
		 	# render 'login'
		 	redirect_to :back
		end
	end

	def forgot_password
	end

	def user_forgot_password
		respose = CONN.post do |req|
		  req.url '/LogicKart/rest/forgot-password'
		  req.headers['Content-Type'] = 'application/json'
		  req.body = params["User"]
		end
		@resposeObj = JSON.parse respose.body
		if(@resposeObj["errorMessage"].blank?)
			flash[:notice] = @resposeObj["successMesage"]
		 	redirect_to login_path
		else
			flash[:notice] = @resposeObj["errorMessage"]
		 	# render 'forgot_password'
		 	redirect_to :back
		 end
	end

	def sign_up
	end

	def user_sign_up
		
		respose = CONN.post do |req|
		  req.url '/LogicKart/rest/signup/newuser'
		  req.headers['Content-Type'] = 'application/json'
		  req.body = params["User"]
		end
		@resposeObj = JSON.parse respose.body
		if(@resposeObj["errorMessage"].blank?)
			flash[:notice] = @resposeObj["successMessage"]
		 	redirect_to login_path
		else
			flash[:notice] = @resposeObj["errorMessage"]
			flash[:info] = params["User"]
		  	redirect_to :back
		 end
	end

	def log_out
		# puts(session[:current_user]["authToken"])
		respose = CONN.post do |req|
		  req.url '/LogicKart/rest/logout/'
		  req.headers['Content-Type'] = 'application/json'
		  req.body = session[:current_user]
		  #'{"authToken" => session[:current_user]["authToken"]}'
		end
		@resposeObj = JSON.parse respose.body
		if(@resposeObj["errorMessage"].blank?)
			flash[:notice] = @resposeObj["successMessage"]
		 	redirect_to login_path
		 	session[:current_user] = nil
		else
			flash[:notice] = @resposeObj["errorMessage"]
			redirect_to errors_internal_server_error_path
		 end
	end

	def change_password
	end

	def user_change_password
		respose = CONN.post do |req|
			req.url "/LogicKart/rest/users/#{session[:current_user]["id"]}/change-password"
			req.headers['Content-Type'] = 'application/json'
			req.body = @new_params
		end
		@resposeObj = JSON.parse respose.body
		if(@resposeObj["errorMessage"].blank?)
			flash[:notice] = @resposeObj["successMessage"]
			redirect_to user_index_path
		else
			flash[:notice] = @resposeObj["errorMessage"]
			redirect_to :back
		end

	end


	private
	def new_body_params
		@new_params = params["User"].merge({"id"=>session[:current_user]["id"],"type"=>session[:current_user]["type"],"authToken" => session[:current_user]["authToken"], "status" => session[:current_user]["status"], "password" => session[:current_user]["password"]})
	end

	def authorized_user
		if (!session[:current_user].nil?)
			if(session[:current_user]["type"] == "user")
				redirect_to user_index_path
			else
				redirect_to admin_index_path
			end
		end
	end

	def unauthorized_user
		if(session[:current_user].nil?)
			redirect_to login_path
		end
	end

	def auth_Token
		user_auth_Token = {"authToken" => session[:current_user]["authToken"]}
		user_auth_Token
	end

end