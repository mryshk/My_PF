class Listener < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,:validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :twitter, :facebook]

  def self.find_or_create_for_oauth(auth)
    find_or_create_by!(email: auth.info.email) do |listener|
      listener.provider = auth.provider,
      listener.uid = auth.uid,
      listener.name = auth.info.name,
      listener.email = auth.info.email,
      listener.password = Devise.friendly_token[0, 20]
    end
  end

  attachment :profile_image # 画像表示のため

  has_one :creater

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_favorites, dependent: :destroy

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

  def unfollow(listener_id) # リレーションシップから引数のリスナーを削除する。
    relationships.find_by(followed_id: listener_id).destroy
  end

  def following?(listener) # フォローしている人に引数のリスナーが存在するかの確認
    followings.include?(listener)
  end

  def followed?(listener) # フォロワーに引数のリスナーが存在するかの確認
    followers.include?(listener)
  end

  # 閲覧数機能の許可
  is_impressionable counter_cache: true

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
