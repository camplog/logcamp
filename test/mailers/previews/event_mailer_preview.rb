# Preview all emails at http://localhost:3000/rails/mailers/event_mailer
class EventMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/event_mailer/notify_members
  def notify_members
  	event = Event.first
    EventMailer.notify_members(event)
  end

end
