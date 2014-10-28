class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_action :require_login
  #before_action :current_user

  helper_method :abilities, :can?

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

    def not_authenticated
      redirect_to login_path, alert: "#{t 'sessions.please_sign_in'}."
    end

    def abilities
      @abilities ||= Six.new
    end

    # simple delegate method for controller & view
    def can?(object, action, subject)
      abilities.allowed?(object, action, subject)
    end

end
