class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # include ApplicationHelper

CONN = Faraday.new(:url => 'http://localhost:8080') do |faraday|
    faraday.request  :url_encoded             
    faraday.response :logger 
    faraday.request  :json
    faraday.adapter  Faraday.default_adapter
  end

  private
  # def current_user
  # 	@current_user ||= session[:current_user]
  # end

  def require_login
    unless(session[:current_user].blank?)
      flash[:error] = "You must log in to access this section"
      redirect_to login_path
    end
  end
end