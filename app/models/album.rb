class Album < ApplicationRecord
  belongs_to :creater
  belongs_to :listener
  has_many :album_musics, dependent: :destroy
  has_many :music_comments, dependent: :destroy
  has_many :music_favorites, dependent: :destroy

  attachment :album_image # 画像表示のため

  # ジャンル用に定義したenum
  enum genre: { ロック: 0, JPOP: 1, アイドル: 2, EDM: 3, KPOP: 4, パンク: 5, レゲエ: 6, HIPHOP: 7 }

  # 閲覧数機能の許可
  is_impressionable counter_cache: true

  def favorited_by?(listener) # ファボをしているかどうかの確認・していれば削除へ
    music_favorites.where(listener_id: listener.id).exists?
  end

  # 検索用
  def self.search(keyword)
    where(genre: "#{keyword}")
  end
end
