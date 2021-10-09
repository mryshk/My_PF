FactoryBot.define do
  factory :relationship do
    follower_id { FactoryBot.build(:listener).id }
    followed_id { FactoryBot.build(:listener).id }
  end
end