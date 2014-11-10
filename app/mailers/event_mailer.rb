class EventMailer < ActionMailer::Base
  default from: ENV['DEFAULT_EMAIL_SENDER']
  layout 'billing_email_template'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_mailer.notify_members.subject
  #
  def notify_members(event)
    @event = event
    mail to: @event.application.members.map(&:email).join(", ")
  end
end
