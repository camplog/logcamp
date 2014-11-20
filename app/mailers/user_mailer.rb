class UserMailer < ActionMailer::Base
  default from: "#{I18n.t 'site_name'} <#{ENV['DEFAULT_EMAIL_SENDER']}>"
  default reply_to: ENV['DEFAULT_CONTACT_EMAIL']

  layout 'email_template'

  def reset_password_email(user)
    @user = user
    mail(to: user.email)
  end

  def welcome(user)
  	@user = user
  	mail(to: user.email)
  end

  def send_invitation(user, application)
    @user = user
    @url = if user.reset_password_token
      change_password_url(token: user.reset_password_token, application: application.id)
    else
      application_users_url application
    end

    mail(to: user.email)
  end

end
