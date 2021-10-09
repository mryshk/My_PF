class Public::ListenersController < ApplicationController
  def show
    @listener = Listener.find(params[:id])
    @posts = @listener.posts.page(params[:page])
    @post_favorite_rank = Post.find(PostFavorite.group(:post_id).order('count(:post_id) desc').pluck(:post_id))
    @post_impression_rank = Post.all.order(impressions_count: 'DESC').page(params[:page])
  end

  def edit
    @listener = Listener.find(params[:id])
  end

  def update
    @listener = Listener.find(params[:id])
    @listener.update(listener_params)
    redirect_to listener_path(@listener)
  end

  private

  def listener_params
    params.require(:listener).permit(:name, :caption, :profile_image)
  end
end
