class OauthsController < ApplicationController
  skip_before_action :require_login

  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def create
    auth = request.env['omniauth.auth']
    # puts "**** #{auth} ****"
    user = Authentication.find_by(provider: auth['provider'], uid: auth['uid']).try(:user) || User.create_with_omniauth(auth)
    # Let's sign in the user
    session[:user_id] = user.id
    # Use Sorcery remember_me method
    user.remember_me!
    redirect_to feed_path
  end

  # By default, it is supposed to raise an exception in development mode
  # and redirect otherwise. Here, we want real world feeling,
  # therefore redirecting.
  # http://stackoverflow.com/questions/10963286/callback-denied-with-omniauth
  def failure
    redirect_to login_path, alert: "#{t 'sessions.oauth_failure', default: 'Session not opened. Try again or register'}."
  end
end
