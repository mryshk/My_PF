class Artist::AlbumsController < ApplicationController
  # 権限確認（cancancan）
  authorize_resource only: [:new, :create,:edit,:update,:destroy]
  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    @album.creater_id = current_listener.creater.id
    @album.save
    redirect_to artist_album_path(@album)
  end

  def show
    @album = Album.find(params[:id])
    @album_musics = AlbumMusic.where(album_id: params[:id]).all
    impressionist(@album, nil)
    @music_impression_rank = AlbumMusic.all.order(impressions_count: 'DESC').page(params[:page])
    # メニュー用
    # 自分の所属するグループを全て集める。
    mygroup_ids = current_listener.group_listeners.pluck(:group_id)
    @mygroups = Group.where(id: mygroup_ids)
  end

  def index
    @albums = Album.page(params[:page]).per(2)
    @album_impression_rank = Album.all.order(impressions_count: 'DESC').page(params[:page])
    # メニュー用
    # 自分の所属するグループを全て集める。
    mygroup_ids = current_listener.group_listeners.pluck(:group_id)
    @mygroups = Group.where(id: mygroup_ids)
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    @album.update(album_params)
    redirect_to artist_album_path(@album)
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to artist_albums_path
  end

  def search
    @search = Album.where(genre_params).page(params[:page]).reverse_order
    @keyword = params.permit(:genre)

    # メニュー用
    # 自分の所属するグループを全て集める。
    mygroup_ids = current_listener.group_listeners.pluck(:group_id)
    @mygroups = Group.where(id: mygroup_ids)
    render "search"
  end

  private

  def album_params
    params.require(:album).permit(:name, :caption, :album_image, :genre, :album_url)
  end

  def genre_params
    params.permit(:genre)
  end
end
