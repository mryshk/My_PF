class Album < ApplicationRecord
  belongs_to :creater
  has_many :album_musics,dependent: :destroy
  has_many :music_comments, dependent: :destroy
  has_many :music_favorites, dependent: :destroy

  def favorited_by?(listener)
    music_favorites.where(listener_id: listener.id).exists?
  end

  def self.search(keyword)
    where(["name like? OR genre like?","%#{keyword}%","%#{keyword}%" ])
  end
end
