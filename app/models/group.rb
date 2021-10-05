class Group < ApplicationRecord
  attachment :image
  has_many :group_listeners
  has_many :listeners, through: :group_listeners
  validates :name, presence: true

  def joined_by?
    group_listeners.where(listener_id: listener.id).exists?
  end

end
