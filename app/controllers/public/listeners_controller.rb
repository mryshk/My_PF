class Public::ListenersController < ApplicationController
  def show
    @listener = Listener.find(params[:id])
    @posts = @listener.posts.reverse_order
    @bookmarks = PostFavorite.where(listener_id: @listener.id).reverse_order
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
    params.require(:listener).permit(:name, :caption, :profile_image, :listener_type, :email)
  end
end
