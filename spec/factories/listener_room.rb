FactoryBot.define do
  factory :listener_room do
    association :listener
    association :room
  end
end
