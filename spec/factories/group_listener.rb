FactoryBot.define do
  factory :group_listener do
    association :group
    association :listener
  end

end