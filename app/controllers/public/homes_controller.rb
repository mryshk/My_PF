class Public::HomesController < ApplicationController
  # フォローしている人のみを表示。タイムライン機能。

  def top
    @Posts = Post.where(user_id:[current_user,*current_user.following_ids]).page(params[:page]).reverse_order
  end

  def about
  end
end
