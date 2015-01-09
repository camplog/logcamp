require 'test_helper'

class EventMailerTest < ActionMailer::TestCase
  setup do
    @event = events(:one)
  end

  test "notify_members" do
    mail = EventMailer.notify_members(@event).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?
    # assert_equal "Notify members", mail.subject
    assert_equal @event.application.members.map(&:email).join(", "), mail.to
    # assert_equal ["from@example.com"], mail.from
    # assert_match "Hi", mail.body.encoded
  end

end
