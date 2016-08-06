require 'test_helper'

class EventMailerTest < ActionMailer::TestCase
  setup do
    @event = events(:one)
  end

  test "notify_members" do
    @event.application.members << [ users(:one), users(:two) ]
    mail = EventMailer.notify_members(@event).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal "Event received", mail.subject
    assert_equal [users(:one).email, users(:two).email], mail.to
  end

end
