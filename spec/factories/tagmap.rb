FactoryBot.define do
  factory :tagmap do
    association :post
    association :tag
    tag_id { FactoryBot.create(:tag).id }
    post_id { FactoryBot.create(:post).id }
  end
end
