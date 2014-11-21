FactoryGirl.define do
  factory :search do
    name 'Search 1'
    color 'purple'
    criteria '[{"status":"warning"}]'

    user
  end
end
