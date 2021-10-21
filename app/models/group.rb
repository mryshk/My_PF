class Group < ApplicationRecord
  attachment :image
  has_many :group_listeners, dependent: :destroy
  has_many :group_chats, dependent: :destroy
  has_many :listeners, through: :group_listeners,dependent: :destroy
  validates :name, presence: true

  def joined_by?(listener_id)
    group_listeners.where(listener_id: listener_id).exists?
  end
end
