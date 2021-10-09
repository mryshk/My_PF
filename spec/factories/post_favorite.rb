FactoryBot.define do
  factory :post_favorite do
    association :post
    association :listener
  end
end
