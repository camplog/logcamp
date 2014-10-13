class Api::BaseController < ApplicationController
  skip_before_action :require_login
  before_action :restrict_access

  private

	  def restrict_access
	    if request.method != "OPTIONS"
	      authenticate_or_request_with_http_token do |token, options|
          api_key = Application.where(auth_token: token).any?
          @current_application = Application.find_by(auth_token: token) if api_key
        end
	    end
	  end

end
