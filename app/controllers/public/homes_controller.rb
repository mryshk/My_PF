class Public::HomesController < ApplicationController
  before_action :set_menu,only:[:home_post,:home_album]


  def top
  end

  def home_post
    # フォローしている人のみを表示。タイムライン機能。
    @listener = Listener.find(current_listener.id)
    @posts = @listener.followings_posts_with_reposts.page(params[:page]).per(10).reverse_order
    @post_favorite_rank = Post.includes(:favo_users).sort { |a, b| b.favo_users.size <=> a.favo_users.size }
    @post_impression_rank = Post.all.order(impressions_count: 'DESC').page(params[:page])
  end

  def home_album
    @albums = Album.where(listener_id: [current_listener, *current_listener.following_ids]).page(params[:page]).includes(:listener).per(2).reverse_order
    @album_impression_rank = Album.all.order(impressions_count: 'DESC').page(params[:page])
    @creaters = Listener.where(listener_type: 1).includes(:followers).sort { |a, b| b.followers.size <=> a.followers.size }
  end

  def set_menu
    # メニュー用
    # 自分の所属するグループを全て集める。
    mygroup_ids = current_listener.group_listeners.pluck(:group_id)
    @mygroups = Group.where(id: mygroup_ids)
  end

end
