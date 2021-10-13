class Artist::MusicFavoritesController < ApplicationController
  def create
    @album = Album.find_by(id: params[:album_id])
    @album_music = AlbumMusic.find_by(id: params[:album_music_id])
    @favorite = MusicFavorite.new
    @favorite.album_id = @album.id
    @favorite.album_music_id = @album_music.id
    @favorite.listener_id = current_listener.id
    @favorite.save
  end

  def destroy
    @favorite = MusicFavorite.find_by(id: params[:id], album_id: params[:album_id], album_music_id: params[:album_music_id])
    @album = Album.find_by(id: params[:album_id])
    @album_music = AlbumMusic.find_by(id: params[:album_music_id])
    @favorite.destroy

    @favorite = MusicFavorite.find_by(album_id: @album.id, album_music_id: @album_music.id, listener_id: current_listener.id)
  end

end
