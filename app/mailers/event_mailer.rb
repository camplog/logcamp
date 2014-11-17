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
    @color_code =
    case @event.status
    when 'log', 'debug', 'warm', 'warning'
      'e78c05' # orange
    when 'victory', 'all-good', 'good', 'positive', 'excellent'
      '53b44f' # green
    when 'information', 'news', 'new', 'cold'
      '12a9da' # light-blue
    when 'failure', 'fail', 'exception', 'danger', 'fire', 'achtung', 'serious', 'injury', 'hot'
      'e9322d' # red
    when 'special'
      '563d7c' # purple
    else
      '9d988e' # grey
    end
    mail to: @event.application.members.map(&:email).join(", ")
  end
end