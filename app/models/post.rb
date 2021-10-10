class Post < ApplicationRecord
  attachment :picture
  belongs_to :listener
  has_many :post_comments, dependent: :destroy
  has_many :post_favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :tagmaps, dependent: :destroy
  has_many :tags, through: :tagmaps

  # ファボモデルに自分が存在するかどうか。していたら削除。なかったら作成。
  def favorited_by?(listener)
    post_favorites.where(listener_id: listener.id).exists?
  end
  # 検索機能。投稿内容のキーワードで検索。前後関係なしにどれか一致すればヒットする。
  def self.search(keyword)
    where(["post_tweet like?", "%#{keyword}%"])
  end
  # 並び替え機能。プルダウンで取得した用語で並び替え内容を場合分けしている。
  def self.sort(order)
    case order
    # 新しい順
    when 'new'
      return all.order(created_at: :DESC)
    # 古い順
    when 'old'
      return all.order(creater_at: :ASC)
    # いいねが多い順
    when 'likes'
      return find(PostFavorite.group(:post_id).order(Arel.sql('count(post_id) desc')).pluck(:post_id))
    end
  end

  # 閲覧数機能の許可
  is_impressionable counter_cache: true


end
