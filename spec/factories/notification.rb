FactoryBot.define do
  factory :notification do
    association :post
    active_id { FactoryBot.build(:listener).id }
    passive_id { FactoryBot.build(:listener).id }
    association :post_comment
    action { Faker::Lorem.characters(number: 10) }
    checked { Faker::Boolean.boolean }
  end
end
