FactoryBot.define do
  factory :inquiry do
    name { Faker::Name.name }
    message { Faker::Lorem.characters(number: 30) }
    email { Faker::Internet.email }
  end
end
