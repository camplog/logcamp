class RegistrationsController < ApplicationController
  before_filter :require_login, only: [:edit, :update]
  layout 'login', only: [:new, :create]

  def new
    @user = User.new
  end

  def create
	  @user = User.new(safe_params)

	  if @user.save
	  	auto_login(@user)
      UserMailer.welcome(@user).deliver_now

      redirect_to root_url
    else
     render :new
	  end
	end

	def edit
		@user = current_user
	end

	def update
    if params[:user][:password].blank?
      params[:user].delete('password')
      params[:user].delete('password_confirmation')
    end

    @user = User.find(current_user.id)

    respond_to do |format|
      if @user.update(safe_params)
        format.html { redirect_to profile_url, notice: "#{t 'profile.updated', default: 'Profile was successfully updated'}." }
      else
        format.html { render action: "edit" }
      end
    end
	end

  private

    def safe_params
      params.require(:user).permit(:email, :full_name, :password, :authentications_attributes)
    end

end