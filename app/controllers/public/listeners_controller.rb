class Public::ListenersController < ApplicationController
  before_action :set_listener

  def set_listener
    @listener = Listener.find(params[:id])
  end

  def show
    @posts = @listener.posts.reverse_order
    @bookmarks = PostFavorite.where(listener_id: @listener.id).includes(:post).reverse_order
    @reposts = Repost.where(listener_id: @listener.id).includes(:post).reverse_order
  end

  def edit
  end

  def update
    @listener.update(listener_params)
    redirect_to listener_path(@listener)
  end

  private

  def listener_params
    params.require(:listener).permit(:name, :caption, :profile_image, :profile_back_image, :listener_type, :email)
  end
end
