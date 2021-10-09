FactoryBot.define do
  factory :post_comment do
    association :post
    association :listener
  end

end