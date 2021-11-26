class Public::ListenersController < ApplicationController
  # 本人確認。 自分以外の人をアクセス不可にするための確認。
  before_action :ensure_listener,only:[:edit,:update]

  def show
    @listener = Listener.find(params[:id])
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

  # 本人確認 本人以外であれば、ホーム画面へ遷移。
  def ensure_listener
    @listener = Listener.find(params[:id])
    if @listener.id != current_listener.id
      redirect_to home_post_path, alert: '画面を閲覧する権限がありません。'
    end
  end

  def listener_params
    params.require(:listener).permit(:name, :caption, :profile_image, :profile_back_image, :listener_type, :email)
  end
end
