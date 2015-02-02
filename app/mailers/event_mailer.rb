class EventMailer < ActionMailer::Base
  default from: ENV['DEFAULT_EMAIL_SENDER']
  layout 'billing_email_template'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  # en.event_mailer.notify_members.subject
  #
  def notify_members(event)
    @event = event
    @color_code =
    case @event.status
    when 'log', 'debug', 'warm', 'warning', 'inactive', 'deactivated', 'pause', 'hold'
      'e78c05' # orange
    when 'victory', 'all-good', 'good', 'positive', 'excellent', 'success', 'succes',
         'active', 'activated', 'created', 'granted', 'on', 'played', 'recorded',
         'notified', 'sent', 'started', 'start', 'resume', 'bueno'
      '53b44f' # green
    when 'information', 'news', 'new', 'cold', 'archived'
      '12a9da' # light-blue
    when 'failure', 'fail', 'exception', 'danger', 'fire', 'achtung', 'serious',
         'injury', 'hot', 'error', 'off', 'deleted', 'destroyed', 'stop', 'stopped'
      'e9322d' # red
    when 'special', 'misc', 'magic'
      '563d7c' # purple
    else
      '9d988e' # grey
    end
    mail(from: "#{event.application.name} <#{ENV['DEFAULT_EMAIL_SENDER']}>", to: @event.application.members.map(&:email).join(", "))
  end
end