FactoryGirl.define do
  factory :event do
    status 'warning'
    message 'Test'
    metadata '{"status":"warning","message":"test"}'
    alert true
    keywords 'test'

    application
  end
end
