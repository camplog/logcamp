class OauthsController < ApplicationController
  skip_before_filter :require_login

  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    @user = User.new
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    puts "**** #{auth_params}"
    begin
    if @user = login_from(provider)
      # user has already linked their account with github
      redirect_to dashboard_path
      flash[:notice] = "Logged in from #{provider.titleize}!"
    else
      begin
        @user = create_from(provider) #add_provider_to_user(provider) #
        reset_session # protect from session fixation attack
        auto_login(@user)
        redirect_to root_path
        flash[:notice] = "Logged in from #{provider.titleize}!"
      rescue
        redirect_back_or_to login_url
        flash[:alert] = "Failed to login from #{provider.titleize}. Please try again."
      end
    end
    rescue ::OAuth2::Error => e
      redirect_back_or_to login_url
      flash[:alert] = "An error occured when trying to sign in with #{provider.titleize}."
      puts "**** #{e.code} ****"
      puts e.description
      puts e.message
      puts e.backtrace
    end
  end

  private

    def auth_params
      params.permit(:code, :provider, :state)
    end

end