FactoryBot.define do
  factory :group_chat do
    association :listener
    association :group
    message { Faker::Lorem.characters(number: 30) }
  end
end
