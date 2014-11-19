class SessionsController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create, :destroy]
  layout 'public', only: [:new, :create]

	def new
	end

	def create
	  if params[:session]
	    user = login(params[:session][:email], params[:session][:password], params[:session][:remember_me])
	  else
	  	user = login(params[:email], params[:password], params[:remember_me])
	  end

    respond_to do |format|
      if user
		  	format.html { redirect_back_or_to root_url}
		  else
			  format.html { render :new }
			  flash.now.alert = "#{t 'sessions.error', default: 'Invalid email/password combination'}."
		  end
    end
	end

	def destroy
    logout
	  redirect_to root_url #, notice: "#{t 'sessions.signed_out', default: 'Signed out'}."
	end
end