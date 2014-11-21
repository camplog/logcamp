FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "test#{n}@demo.com"}
    full_name 'Test'
    password '12345678'
  end
end
