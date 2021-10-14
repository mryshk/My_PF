class Artist::AlbumsController < ApplicationController
  # 権限確認（cancancan）
  authorize_resource
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
    @album_musics = AlbumMusic.where(album_id: params[:id]).page(params[:page])
  end

  def index
    @albums = Album.page(params[:page])
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
    @search = Album.search(params[:genre]).page(params[:page]).reverse_order
    @keyword = params[:genre]
    render "search"
  end

  private

  def album_params
    params.require(:album).permit(:name, :caption, :album_image_id, :genre, :album_url)
  end
end
