class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  # before_action :require_login
  before_action :current_user

  private

    def current_user
    	# session[:user_id] = User.includes(:authentications).first
      if session[:user_id]
        @current_user ||= User.find(session[:user_id]) #if session[:user_id]
      else
        @current_user = User.first
      end
    end
    helper_method :current_user

    def require_login
      redirect_to login_url, alert: "#{t 'sessions.please_sign_in'}." if current_user.nil?
    end
end
