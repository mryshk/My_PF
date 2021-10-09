class Public::HomesController < ApplicationController
  # フォローしている人のみを表示。タイムライン機能。

  def top
    posts = Post.where(listener_id: [current_listener, *current_listener.following_ids])
    @posts = posts.page(params[:page]).reverse_order
    @post_favorite_rank = Post.find(PostFavorite.group(:post_id).order('count(:post_id) desc').pluck(:post_id))
    @post_impression_rank = Post.all.order(impressions_count: 'DESC').page(params[:page])
  end

  def about
  end
end
