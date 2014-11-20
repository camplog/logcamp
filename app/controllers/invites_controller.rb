class InvitesController < ApplicationController

  before_action :set_application, only: [:create, :update]

  def create
    params[:email_list].split(',').each do |email|
      email = email.strip
      if email =~ User::EMAIL_FORMAT
        @user = User.find_by(email: email)

        unless @user
          # user not exist
          full_name = email.split('@').first

          @user = User.create(
            email: email,
            full_name: full_name,
            password: SecureRandom.hex[0...User::PWD_DEFAULT_LENGTH],
            reset_password_token: SecureRandom.hex[0...User::TOKEN_LENGTH],
            reset_password_email_sent_at: Time.now.in_time_zone
          )
        end

        # User sing_in_count include :
        # - User never login
        # - New user
        UserMailer.send_invitation(@user, @application).deliver_later if @user.sign_in_count <= 0
        @application.members << @user unless @application.members.exists?(@user.id)
      end
    end if params[:email_list].present? and @application

    redirect_to application_users_path(@application), notice: t('invites.send_invitation_success')
  end

  def update
    user = User.find_by(id: params[:id])
    UserMailer.send_invitation(user, @application).deliver_later if user && user.sign_in_count <= 0

    redirect_to application_users_path(@application), notice: t('invites.send_invitation_success')
  end

  private
    def set_application
      @application = Application.find(params[:application_id])
    end

end