FactoryBot.define do
  factory :music_favorite do
    association :listener
    association :album
    association :album_music
  end
end
