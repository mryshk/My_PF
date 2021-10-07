class Public::ListenersController < ApplicationController


  def show
    @listener = Listener.find(params[:id])
    @posts = @listener.posts.page(params[:page])
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
    params.require(:listener).permit(:name,:caption,:profile_image)
  end

end
