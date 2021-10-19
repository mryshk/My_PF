class Public::HomesController < ApplicationController
  # フォローしている人のみを表示。タイムライン機能。

  def top

  end

  def home
    posts = Post.where(listener_id: [current_listener, *current_listener.following_ids])
    @posts = posts.page(params[:page]).reverse_order
    @post_favorite_rank = Post.includes(:favo_users).sort {|a,b| b.favo_users.size <=> a.favo_users.size}
    @post_impression_rank = Post.all.order(impressions_count: 'DESC').page(params[:page])
    # 自分の所属するグループを全て集める。
    mygroup_ids = current_listener.group_listeners.pluck(:group_id)
    @mygroups = Group.where(id: mygroup_ids)
  end

  def about
  end
end
