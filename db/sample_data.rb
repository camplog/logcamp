# encoding: utf-8
require 'ffaker'

puts 'GENERATING SAMPLE DATA ...'

puts "creating users"

5.times do |x|
  print '.'
  u = x + 1
  user = User.create!(
    email: "user#{u}@email.com",
    full_name: [FFaker::Name.first_name, FFaker::Name.last_name].join(' '),
    password: "123123",
    activation_state: 'active',
    activation_token: nil
  )
end
User.first.activate!
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
    message: FFaker::Lorem.sentence,
    alert: [true, false].sample,
    application_id: Application.pluck(:id).sample
  )
  event.update!(metadata: event.attributes)
end
print "\n"

e = Event.first
e.metadata = {amount: '150.52', products: 'Toy, Car and Basket-Ball', source: 'POS'}
e.save

puts "creating memberships"

10.times do |i|
  print '.'
  x = i + 1
  app = Application.all.sample
  app.members << [User.all - app.members].sample
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