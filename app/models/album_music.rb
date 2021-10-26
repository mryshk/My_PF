class AlbumMusic < ApplicationRecord
  belongs_to :album
  belongs_to :creater
  has_many :music_comments, dependent: :destroy
  has_many :music_favorites, dependent: :destroy

  # 閲覧数機能の許可
  is_impressionable counter_cache: true

  # ファボモデルに自分が存在するかどうか。していたら削除。なかったら作成。
  def favorited_by?(listener)
    music_favorites.where(listener_id: listener.id).exists?
  end
end
