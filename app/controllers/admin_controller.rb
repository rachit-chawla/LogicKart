class AdminController < ApplicationController

	before_action :new_body_params, only: [:user_change_password, :aupdate, :admin_change_password]
	before_action :authorized_user, only: [:login, :sign_up]
	before_action :admin_authorized, only: [:index, :delete, :users_list, :user_new_user, :new_user, :ashow, :user_show, :aedit, :user_edit, :aupdate, :adupdate, :achange_password, :admin_change_password]
	before_action :unauthorized_user, only: [:admin_change_password, :achange_password, :adupdate, :aupdate, :user_edit, :aedit, :user_show, :ashow, :index, :change_password, :log_out, :show, :users_list, :delete, :user_new_user, :new_user]
	$resp = nil
	
  def index
  	
  end

  def create
  end

  def delete
  	respose = CONN.post do |req|
		  req.url "/LogicKart/rest/admin/users/#{params["id"]}/delete"
		  req.headers['Content-Type'] = 'application/json'
		  req.body = auth_Token
		end
		@resposeObj = JSON.parse respose.body
		if(@resposeObj["ErrorMessage"].blank?)
			flash[:notice] = @resposeObj["SuccessMessage"]
		else
			flash[:notice] = @resposeObj["ErrorMessage"]
		end
		redirect_to userslist_path				
  end

  def users_list
  	respose = CONN.post do |req|
		  req.url '/LogicKart/rest/admin/users/'
		  req.headers['Content-Type'] = 'application/json'
		  req.body = auth_Token
		end
		@resposeObj = JSON.parse respose.body
		if(!@resposeObj["errorMessage"].blank?)
			flash[:notice] = @resposeObj["errorMessage"]
			redirect_to errors_unauthorized_path
			@resposeObj1 = []
		else
			@resposeObj1 = @resposeObj["userList"]
		end
  end

  def user_new_user
  	respose = CONN.post do |req|
		  req.url '/LogicKart/rest/admin/users/new-user'
		  req.headers['Content-Type'] = 'application/json'
		  req.body = params_auth_token
	end
	@resposeObj = JSON.parse respose.body
	if(@resposeObj["errorMessage"].blank?)
			flash[:notice] = @resposeObj["successMesage"]
		 	redirect_to userslist_path
		else
			flash[:notice] = @resposeObj["errorMessage"]
		 	# render 'forgot_password'
		 	redirect_to :back
	end
  end

  def new_user
  end

  def show
  end

  def ashow
  		respose = CONN.post do |req|
		  req.url "/LogicKart/rest/admin/users/#{session[:current_user]["id"]}/view"
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

	def user_show
  		respose = CONN.post do |req|
		  req.url "/LogicKart/rest/admin/users/#{params["id"]}/view"
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
				redirect_to admin_index_path
			end
		end
	end

	def aedit
		respose = CONN.post do |req|
		  req.url "/LogicKart/rest/admin/users/#{session[:current_user]["id"]}/view"
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
				redirect_to admin_index_path
			end
		end
	end

	def user_edit
		respose = CONN.post do |req|
		  req.url "/LogicKart/rest/admin/users/#{params["id"]}/view"
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
				redirect_to admin_index_path
			end
		end
	end

	def aupdate
		respose = CONN.post do |req|
		  req.url "/LogicKart/rest/admin/users/#{session[:current_user]["id"]}/update"
		  req.headers['Content-Type'] = 'application/json'
		  req.body = @new_params
		end
		@resposeObj = JSON.parse respose.body
		if(@resposeObj["errorMessage"].blank?)
			flash[:notice] = @resposeObj["successMesage"]
		 	redirect_to admin_index_path
		else
			flash[:notice] = @resposeObj["errorMessage"]
		 	# render 'forgot_password'
		 	redirect_to :back
		 end
	end

	def adupdate
		respose = CONN.post do |req|
		  req.url "/LogicKart/rest/admin/users/#{params["User"]["id"]}/update"
		  req.headers['Content-Type'] = 'application/json'
		  req.body = params_auth_token
		end
		@resposeObj = JSON.parse respose.body
		if(@resposeObj["errorMessage"].blank?)
			flash[:notice] = @resposeObj["successMesage"]
		 	redirect_to userslist_path
		else
			flash[:notice] = @resposeObj["errorMessage"]
		 	# render 'forgot_password'
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

	def achange_password
	end

	def admin_change_password
		respose = CONN.post do |req|
			req.url "/LogicKart/rest/users/#{session[:current_user]["id"]}/change-password"
			req.headers['Content-Type'] = 'application/json'
			req.body = @new_params
		end
		@resposeObj = JSON.parse respose.body
		if(@resposeObj["errorMessage"].blank?)
			flash[:notice] = @resposeObj["successMessage"]
			redirect_to admin_index_path
		else
			flash[:notice] = @resposeObj["errorMessage"]
			redirect_to :back
		end

	end


	private 

	def new_body_params
		@new_params = params["User"].merge({"id"=>session[:current_user]["id"],"type"=>session[:current_user]["type"],"authToken" => session[:current_user]["authToken"], "status" => session[:current_user]["status"], "password" => session[:current_user]["password"]})
	end

	def params_auth_token
		@params_new_user = params["User"].merge({"authToken" => session[:current_user]["authToken"]})
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
		user_auth_Token = {"authToken" => session[:current_user]["authToken"], "type"=>session[:current_user]["type"]}
		user_auth_Token
	end

	def admin_authorized
		if(session[:current_user].nil?)
			redirect_to login_path
		else				
			if(!(session[:current_user]["type"] == "admin"))
			redirect_to errors_unauthorized_path
			end
		end
	end

end
