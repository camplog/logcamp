# encoding: utf-8
require 'ffaker'

puts 'GENERATING SAMPLE DATA ...'

puts "creating users"

3.times do |x|
  print '.'
  u = x + 1
  user = User.create!(
    email: "user#{u}@gmail.com",
    full_name: [Faker::Name.first_name, Faker::Name.last_name].join(' '),
    password: "123123"
  )
end
print "\n"

puts "creating apps"

3.times do |i|
	print '.'
  x = i + 1
  Application.create!(
    name: "app#{x}",
    slug: "app#{x}",
    active: [true, false].sample,
    user_id: User.pluck(:id).sample
  )
end
print "\n"

puts "creating events"

100.times do |i|
	print '.'
  x = i + 1
  Event.create!(
    status: [:info, :error, :warning, :success, :log, :debug].sample,
    message: "Event #{x}",
    application_id: Application.pluck(:id).sample
  )
end
print "\n"