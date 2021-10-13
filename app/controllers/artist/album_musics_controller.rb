class Artist::AlbumMusicsController < ApplicationController

  def new
    @album_music = AlbumMusic.new
  end

  def create
     @album_music = AlbumMusic.new(album_music_params)
     @album_music.save
     redirect_to artist_album_album_music_path(@album_music)
  end

  def show
    @album_music = AlbumMusic.find(params[:id])

  end

  def index
    @album_musics = AlbumMusic.page(params[:page])
  end

  def edit
     @album_music = AlbumMusic.new
  end

  def update
    @album_music = AlbumMusic.find(params[:id])
    @album_music.update(album_music_params)
    redirect_to artist_album_album_music_path(@album_music)
  end

  def destroy
    @album_music = AlbumMusic.find(params[:id])
    @album_music = AlbumMusic.destroy
    redirect_to artist_album_album_musics_path
  end


  private

  def album_music_params
    params.require(:album_music).permit(:name, :caption, :music_url)
  end


end
