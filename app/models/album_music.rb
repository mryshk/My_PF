class AlbumMusic < ApplicationRecord
  belongs_to :album
  has_many :music_comments, dependent: :destroy
  has_many :music_favorites, dependent: :destroy
end
