class RegistrationsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :activate]
  layout 'public', only: [:new, :create]

  def new
    @user = User.new
  end

  def create
	  @user = User.new(safe_params)

	  if @user.save
      # user activation enabled therefore an email is sent to confirm identity
	  	auto_login(@user)
      redirect_to feed_url
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
        format.html { render :edit }
      end
    end
	end

  def activate
    if (@user = User.load_from_activation_token(params[:token]))
      @user.activate!
      redirect_to(login_path, notice: 'Account was successfully activated, you can now sign in.')
      UserMailer.welcome(@user).deliver_later(wait_until: 3.days.from_now)
    else
      not_authenticated
    end
  end

  private

    def safe_params
      params.require(:user).permit(:email, :full_name, :password, :authentications_attributes)
    end

end