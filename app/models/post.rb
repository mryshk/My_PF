class Post < ApplicationRecord
  attachment :picture
  belongs_to :listener
  has_many :post_comments, dependent: :destroy
  has_many :post_favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :tagmaps, dependent: :destroy
  has_many :tags, through: :tagmaps

  def favorited_by?(listener)
    post_favorites.where(listener_id: listener.id).exists?
  end

  def self.search(keyword)
    where(["post_tweet like?", "%#{keyword}%"])
  end
  
  def self.sort(order)
    case order
    when 'new'
      return all.order(created_at: :DESC)
    
    when 'old'
      return all.order(creater_at: :ASC)
    
    when 'likes'
      return find(PostFavorite.group(:post_id).order(Arel.sql('count(post_id) desc')).pluck(:post_id))
    end 
  end
  
  
end
