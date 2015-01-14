class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session # :exception

  before_action :require_login

  helper_method :abilities, :can?

  rescue_from OAuth2::Error do |exception|
    if exception.response.status == 401
      session[:remember_token] = nil
      session[:access_token] = nil
      redirect_to root_url, alert: "Access token expired, try signing in again."
    end
  end

  private

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
