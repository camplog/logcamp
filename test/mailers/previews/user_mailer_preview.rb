# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/send_invitation
  def send_invitation
  	user = User.last
  	application = Application.first
    UserMailer.send_invitation(user, application)
  end

  def welcome
    user = User.first
    UserMailer.welcome(user)
  end

  def reset_password_email
    user = User.first
    UserMailer.reset_password_email(user)
  end

end
