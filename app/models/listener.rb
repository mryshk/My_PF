class Listener < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :twitter, :facebook]

  # SNS認証omniauthのための定義。
  def self.find_or_create_for_oauth(auth)
    find_or_create_by!(email: auth.info.email) do |listener|
      listener.provider =
        auth.provider,
        listener.uid = auth.uid,
        listener.name = auth.info.name,
        listener.email = auth.info.email,
        listener.password = Devise.friendly_token[0, 20]
    end
  end

  attachment :profile_image # 画像表示のため
  attachment :profile_back_image # 背景画像表示のため

  has_one :creater, dependent: :destroy

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_favorites, dependent: :destroy
  has_many :reposts, dependent: :destroy

  has_many :group_listeners, dependent: :destroy
  has_many :groups, through: :group_listeners, dependent: :destroy
  has_many :group_chats, dependent: :destroy

  has_many :chats, dependent: :destroy
  has_many :listener_rooms, dependent: :destroy

  has_many :active_notifications, class_name: 'Notification', foreign_key: 'active_id', dependent: :destroy

  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'passive_id', dependent: :destroy

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy

  has_many :followings, through: :relationships, source: :followed

  has_many :music_comments, dependent: :destroy

  has_many :music_favorites, dependent: :destroy

  # ログイン中のリスナーを引数で取得し、そのリスナーがフォローした人としてリレーションシップに登録される。
  def follow(listener_id)
    relationships.create!(followed_id: listener_id)
  end

  # リレーションシップから引数のリスナーを削除する。
  def unfollow(listener_id)
    relationships.find_by(followed_id: listener_id).destroy
  end

  # フォローしている人に引数のリスナーが存在するかの確認
  def following?(listener)
    followings.include?(listener)
  end
  # フォロワーに引数のリスナーが存在するかの確認
  def followed?(listener)
    followers.include?(listener)
  end

  # リポストに使用。
  # 自分がフォローしている人（自分にフォローされている人）と自分を取得し配列に並べている。
  def followings_with_userself
    Listener.where(id: self.followings.pluck(:id)).or(Listener.where(id: self.id))
  end

  # リポストに使用。
  # タイムラインにフォローしている人の投稿とリポストを一覧表示するための定義
  # PostモデルとRepostモデルを左外部結合を行い、フォローしている人のIDとPostIDで検索取得。
  # それらをorderで並び替え。preloadはN+1問題解決のため。
  def followings_posts_with_reposts
  relation = Post.joins("LEFT OUTER JOIN reposts ON posts.id = reposts.post_id AND (reposts.listener_id = #{self.id} OR reposts.listener_id IN (SELECT followed_id FROM relationships WHERE follower_id = #{self.id}))")
                 .select("posts.*, reposts.listener_id AS repost_listener_id, (SELECT name FROM listeners WHERE id = reposts.listener_id) AS repost_listener_name")
  relation.where(listener_id: self.followings_with_userself.pluck(:id))
          .or(relation.where(id: Repost.where(listener_id: self.followings_with_userself.pluck(:id)).distinct.pluck(:post_id)))
          .where("NOT EXISTS(SELECT 1 FROM reposts sub WHERE reposts.post_id = sub.post_id AND reposts.created_at < sub.created_at)")
          .preload(:listener, :post_comments,:post_favorites, :reposts)
          .order(Arel.sql("CASE WHEN reposts.created_at IS NULL THEN posts.created_at ELSE reposts.created_at END"))
  end

  # 閲覧数機能の許可
  is_impressionable counter_cache: true

  # 通知機能のための定義
  def create_notification_follow!(current_listener)
    temp = Notification.where(["passive_id = ? and active_id = ? and action = ?", current_listener.id, id, 'follow'])
    if temp.blank?
      notification = current_listener.active_notifications.new(
        passive_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end
