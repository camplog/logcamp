FactoryGirl.define do
  factory :application do
    sequence(:name) {|n| "App#{n}"}
    sequence(:slug) {|n| "app#{n}"}
    active true
    auth_token SecureRandom.hex[0...32]

    association :owner, factory: :user
  end
end
