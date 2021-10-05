class Album < ApplicationRecord
  belongs_to :creater
  has_many :album_musics,dependent: :destroy
  has_many :music_comments, dependent: :destroy
  has_many :music_favorites, dependent: :destroy

  def favorited_by?(listener) #ファボをしているかどうかの確認・していれば削除へ
    music_favorites.where(listener_id: listener.id).exists?
  end

  def self.search(keyword) #アルバムの名前とジャンルの検索・キーワードが前後関係なく含んでいたら表示
    where(["name like? OR genre like?","%#{keyword}%","%#{keyword}%" ])
  end
end
