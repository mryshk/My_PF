class Artist::AlbumsController < ApplicationController
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
    @albums = Album.page(params[:page])
  end

  def index
    @albums = Album.page(params[:page])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def search
  end

  private

  def album_params
    params.require(:album).permit(:name, :caption, :album_image_id, :genre, :album_url)
  end
end
