class MusicFavorite < ApplicationRecord
  belongs_to :album
  belongs_to :album_music
end
