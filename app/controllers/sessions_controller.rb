class SessionsController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]
  layout 'public', only: [:new, :create]

	def new
	end

	def create
	  user = login(params[:session][:email], params[:session][:password], params[:session][:remember_me])

    if user
	  	redirect_back_or_to feed_url
	  else
		  flash.now.alert = "#{t 'sessions.error', default: 'Invalid email/password combination'}."
	    render :new
    end
	end

	def destroy
		# sorcery logout method raising nil issue for current user
		# Disabling for now
		# https://github.com/NoamB/sorcery/pull/474
		# https://github.com/NoamB/sorcery/issues/621
		# logout
		reset_session
    current_user = nil

	  redirect_to root_url #, notice: "#{t 'sessions.signed_out', default: 'Signed out'}."
	end

  private

    def increase_login_count(user, credentials)
      user.increment! :sign_in_count
    end
end