class Public::PostFavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @favorite = current_listener.post_favorites.new(post_id: @post.id)
    @favorite.save
    @post.create_notification_by(current_listener)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @favorite = current_listener.post_favorites.find_by(post_id: @post.id)
    @favorite.destroy
  end
end
