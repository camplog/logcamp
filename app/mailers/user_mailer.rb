class UserMailer < ActionMailer::Base
  default from: "#{I18n.t 'site_name'} <#{ENV['DEFAULT_EMAIL_SENDER']}>"
  default reply_to: ENV['DEFAULT_CONTACT_EMAIL']

  layout 'mailer'

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
    @application = application
    @url = if user.reset_password_token
      # user does not exist, therefore needs to change password before joining
      change_password_url(token: user.reset_password_token, application: application.id)
    else
      # user found, let's redirect to the app feed
      application_url(application)
    end

    mail(to: user.email)
  end

  def activation_needed_email(user)
    @user = user
    mail(to: user.email)
  end

end
