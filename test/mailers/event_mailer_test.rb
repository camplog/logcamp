require 'test_helper'

class EventMailerTest < ActionMailer::TestCase
  test "notify_members" do
    mail = EventMailer.notify_members(Event.first)
    assert_equal "Notify members", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
