class Artist::MusicCommentsController < ApplicationController
  def new
    @album = Album.find_by(id: params[:album_id])
    @album_music = AlbumMusic.find_by(id: params[:album_music_id])
    @music_comment = MusicComment.new
  end

  def create
     @music_comment = MusicComment.new(music_comment_params)
     @album = Album.find_by(id: params[:album_id])
     @album_music = AlbumMusic.find_by(id: params[:album_music_id])
     @music_comment.album_id = @album.id
     @music_comment.album_music_id = @album_music.id
     @music_comment.save!
     redirect_to artist_album_album_music_path(@album, @album_music)
  end

  def edit
    @album = Album.find_by(id: params[:album_id])
    @album_music = AlbumMusic.find_by(id: params[:album_music_id])
    @music_comment = MusicComment.find_by(id: params[:id], album_id: params[:album_id], album_music_id: params[:album_music_id])
  end

  def update
    @music_comment = MusicComment.find_by(id: params[:id], album_id: params[:album_id], album_music_id: params[:album_music_id])
    @album = Album.find_by(id: params[:album_id])
    @album_music = AlbumMusic.find_by(id: params[:album_music_id])
    @music_comment.update(music_comment)
    redirect_to artist_album_album_music_path(@album, @album_music)
  end

  def destroy
    @music_comment = MusicComment.find_by(id: params[:id], album_id: params[:album_id], album_music_id: params[:album_music_id])
    @album = Album.find_by(id: params[:album_id])
    @album_music = AlbumMusic.find_by(id: params[:album_music_id])
    @music_comment.destroy
    redirect_to artist_album_album_music_path(@album, @album_music)
  end

  private

  def music_comment_params
    params.require(:music_comment).permit(:listener_id, :album_id, :album_music_id, :comment, :rate)
  end

end
