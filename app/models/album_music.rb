class AlbumMusic < ApplicationRecord
  belongs_to :album
  has_many :music_comments, dependent: :destroy
  has_many :music_favorites, dependent: :destroy

  # ファボモデルに自分が存在するかどうか。していたら削除。なかったら作成。
  def favorited_by?(listener)
    music_favorites.where(listener_id: listener.id).exists?
  end
end
