class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  layout 'public', only: [:new, :create]

	def new
	end

	def create
	  user = login(params[:session][:email], params[:session][:password], params[:session][:remember_me])

    if user
    	user.increment! :sign_in_count
	  	redirect_back_or_to feed_url
	  else
		  flash.now.alert = "#{t 'sessions.error', default: 'Invalid email/password combination'}."
	    render :new
    end
	end

	def destroy
		logout
	  redirect_to root_url #, notice: "#{t 'sessions.signed_out', default: 'Signed out'}."
	end

end
