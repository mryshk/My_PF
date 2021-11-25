class Group < ApplicationRecord
  # 画像投稿のため。
  attachment :image

  # アソシエーション
  has_many :group_listeners, dependent: :destroy
  has_many :group_chats, dependent: :destroy
  has_many :listeners, through: :group_listeners, dependent: :destroy

  # グループ作成のバリデーション
  validates :name, presence: true
  validates :introduction,length: {maximum: 140}

  # グループに参加しているかどうかの確認。
  def joined_by?(listener_id)
    group_listeners.where(listener_id: listener_id).exists?
  end
end
