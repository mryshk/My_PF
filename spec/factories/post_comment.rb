FactoryBot.define do
  factory :post_comment do
    association :post
    association :listener
    comment { Faker::Lorem.characters(number: 30) }
  end
end
