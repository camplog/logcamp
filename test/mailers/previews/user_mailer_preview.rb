# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/send_invitation
  def send_invitation
  	user = User.last
  	application = Application.first
    UserMailer.send_invitation(user, application)
  end

end
