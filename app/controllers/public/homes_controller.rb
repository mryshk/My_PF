class Public::HomesController < ApplicationController
  # メニュー表示用。以下アクションに適用。
  before_action :set_menu, only: [:home_post, :home_album]

  def top
  end

  # 投稿のタイムライン
  def home_post
    # フォローしている人のみを表示。タイムライン機能。
    @listener = Listener.find(current_listener.id)
    @posts = @listener.followings_posts_with_reposts.page(params[:page]).per(4).reverse_order
    # ファボランキング表示用。
    @post_favorite_rank = Post.left_joins(:post_favorites).group(:post_id).order('count(post_id) desc')
    # 閲覧数ランキング表示用。
    @post_impression_rank = Post.all.order(impressions_count: 'DESC').page(params[:page])
  end

  # アルバムのタイムライン
  def home_album
    # アルバムDBからリスナーIDが自分含むフォローユーザーと一致するレコード全てを取得。さらにリスナーテーブルと関連付け。新しい順に並び替えし@albums変数へ。
    @albums = Album.where(listener_id: [current_listener, *current_listener.following_ids]).page(params[:page]).includes(:listener).per(2).reverse_order
    # 閲覧数ランキング表示用。
    @album_impression_rank = Album.all.order(impressions_count: 'DESC').page(params[:page])
    # クリエイターのフォロワーランキング表示用。
    @creaters = Listener.where(listener_type: 1).includes(:followers).sort { |a, b| b.followers.size <=> a.followers.size }
  end

  # ゲストログイン用
  def guest_signin
    listener = Listener.find_or_create_by(email: "guest@example.com") do |listener|
      listener.name = "Guest"
      listener.password = SecureRandom.alphanumeric(10)
    end
    sign_in listener
    redirect_to home_post_path
  end



  private

  # メニュー用
  # 自分の所属するグループを全て集める。
  def set_menu
    mygroup_ids = current_listener.group_listeners.pluck(:group_id)
    @mygroups = Group.where(id: mygroup_ids)
  end
end
