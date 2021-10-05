class Post < ApplicationRecord
  attachment :post_image
  belongs_to :listener
  has_many :post_comments, dependent: :destroy
  has_many :post_favorites, dependent: :destroy

  def favorited_by?(listener)
    post_favorites.where(listener_id: listener.id).exists?
  end

  def self.search(keyword)
    where(["post_tweet like?","%#{keyword}%"])
  end
end
