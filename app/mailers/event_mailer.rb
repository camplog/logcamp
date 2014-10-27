class EventMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_mailer.notify_members.subject
  #
  def notify_members
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
