# encoding: utf-8
require 'ffaker'

puts 'GENERATING SAMPLE DATA ...'

puts "creating users"

5.times do |x|
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

10.times do |i|
	print '.'
  x = i + 1
  Application.create!(
    name: "app#{x}",
    slug: "app#{x}",
    active: [true, false].sample,
    owner_id: User.pluck(:id).sample
  )
end
print "\n"

app = Application.first
app.update!(auth_token: '111')

puts "creating events"

100.times do |i|
	print '.'
  x = i + 1
  event = Event.create!(
    status: [:info, :error, :warning, :success, :log, :debug, :failure, :special].sample,
    message: Faker::Lorem.sentence,
    alert: [true, false].sample,
    application_id: Application.pluck(:id).sample
  )
  event.update!(metadata: event.attributes.to_json)
end
print "\n"

puts "creating memberships"

10.times do |i|
  print '.'
  x = i + 1
  Application.all.sample.members << User.all.sample
end
print "\n"

puts "creating searches"

10.times do |i|
  print '.'
  x = i + 1
  search = Search.create!(
    name: "Search #{x}",
    color: ['orange', 'light-blue', 'blue', 'green', 'red', 'black', 'purple'].sample,
    criteria: [status: ['log', 'warning', 'error', 'success', 'debug'].sample].to_json,
    user_id: User.pluck(:id).sample
  )
end
print "\n"