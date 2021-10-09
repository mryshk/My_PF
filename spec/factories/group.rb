FactoryBot.define do
  factory :group do
    owner_id { FactoryBot.build(:listener).id }
    name { Faker::Name.name}
    introduction { Faker::Lorem.characters(number:30)  }
    image_id { Faker::Lorem.characters(number:20)  }
  end

end