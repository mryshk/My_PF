class Artist::AlbumsController < ApplicationController
  # 権限確認（cancancan）
  authorize_resource only: [:new, :create, :edit, :update, :destroy]
  # メニューバー用。メニューバーがあるページのアクションのみ。
  before_action :set_menu, only: [:show, :index, :search, :search_genre]

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    @album.creater_id = current_listener.creater.id
    @album.listener_id = current_listener.id
    @album.save
    redirect_to artist_album_path(@album)
  end

  def show
    @album = Album.find(params[:id])
    @album_musics = AlbumMusic.where(album_id: params[:id]).all
    impressionist(@album, nil)
    @music_impression_rank = AlbumMusic.all.order(impressions_count: 'DESC').page(params[:page])
  end

  def index
    @albums = Album.page(params[:page]).per(2).reverse_order
    @album_impression_rank = Album.all.order(impressions_count: 'DESC').page(params[:page])
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    @album.listener_id = current_listener.id
    @album.update(album_params)
    redirect_to artist_album_path(@album)
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to home_album_path
  end

  def search
    @search = Album.where('name LIKE ?', "%#{params[:keyword]}%").page(params[:page]).per(5).reverse_order
    # インクリメンタルサーチのため。
    respond_to do |format|
      format.html
      format.json
    end
  end

  def search_genre
    @search = Album.where(genre_params).page(params[:page]).per(2).reverse_order
    @keyword = params.permit(:genre)
  end

  def set_menu
    # メニュー用
    # 自分の所属するグループを全て集める。
    mygroup_ids = current_listener.group_listeners.pluck(:group_id)
    @mygroups = Group.where(id: mygroup_ids)
  end

  private

  # 新規登録用のパラメーター
  def album_params
    params.require(:album).permit(:name, :caption, :album_image, :genre, :album_url)
  end

  # ジャンル検索用のパラメーター
  def genre_params
    params.permit(:genre)
  end
end
