class Listener < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image #画像表示のため


  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_favorites, dependent: :destroy

  has_many :group_listeners
  has_many :groups, through: :group_listeners

  has_many :chats, dependent: :destroy
  has_many :listener_rooms, dependent: :destroy

  has_many :active_notifications,class_name: 'Notification',foreign_key: 'active_id',dependent: :destroy
  has_many :passive_notifications,class_name: 'Notification',foreign_key: 'passive_id',dependent: :destroy

  has_many :reverse_of_relationships, class_name: "Relationship",foreign_key: "followed_id",dependent: :destroy
  has_many :followers, through: :reverse_of_relationships ,source: :follower

  has_many :relationships, class_name: "Relationship",foreign_key: "follower_id",dependent: :destroy
  has_many :followings ,through: :relationships, source: :followed

  def follow(listener_id)　#ログイン中のリスナーを引数で取得し、そのリスナーがフォローした人としてリレーションシップに登録される。
    relationships.create(followed_id: listener_id)
  end

  def unfollow(listener_id) #リレーションシップから引数のリスナーを削除する。
    relationships.find_by(followed_id: listener_id).destroy
  end

  def following?(listener) #フォローしている人に引数のリスナーが存在するかの確認
    followings.include?(listener)
  end

  def followed?(listener) #フォロワーに引数のリスナーが存在するかの確認
    followers.include?(listener)
  end


end
