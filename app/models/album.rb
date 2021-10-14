class Album < ApplicationRecord
  belongs_to :creater
  has_many :album_musics, dependent: :destroy
  has_many :music_comments, dependent: :destroy
  has_many :music_favorites, dependent: :destroy

  attachment :album_image # 画像表示のため

  enum genre: { ロック: 0, JPOP: 1, アイドル: 2, EDM: 3, KPOP: 4, パンク: 5, レゲエ: 6, HIPHOP: 7 }

  def favorited_by?(listener) # ファボをしているかどうかの確認・していれば削除へ
    music_favorites.where(listener_id: listener.id).exists?
  end

  def self.search(keyword)
    where(genre: "#{keyword}")
  end
end
