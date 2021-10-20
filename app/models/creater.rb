class Creater < ApplicationRecord
  belongs_to :listener
  has_many :albums, dependent: :destroy
  has_many :album_musics, dependent: :destroy
  has_many :music_comments, dependent: :destroy
  has_many :music_favorites, dependent: :destroy
end
