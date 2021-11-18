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
    # Natural Language APIから情報取得。スコアカラムへ格納。
    @music_comment.score = Language.get_data(music_comment_params[:comment])
    @music_comment.save!
    # create.js用
    @music_comments = @album_music.music_comments
    @music_comment_n = MusicComment.new
  end

  def show
    @album = Album.find_by(params[:album_id])
    @album_music = AlbumMusic.find_by(params[:album_music_id])
    @music_comment = MusicComment.find(params[:id])
    @music_comment_n = MusicComment.new
    @comments = MusicComment.includes(:listener).where(reply_comment: @music_comment.id)
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
    # Natural Language APIから情報取得。スコアカラムへ格納
    @music_comment.score = Language.get_data(music_comment_params[:comment])
    @music_comment.update(music_comment_params)
    redirect_to artist_album_album_music_path(@album, @album_music)
  end

  def destroy
    @music_comment = MusicComment.find_by(id: params[:id], album_id: params[:album_id], album_music_id: params[:album_music_id])
    @album = Album.find_by(id: params[:album_id])
    @album_music = AlbumMusic.find_by(id: params[:album_music_id])
    @music_comment.destroy

    # destroy.js用
    @music_comments = @album_music.music_comments
    @music_comment_n = MusicComment.new
  end


  def reply_create
    @album = Album.find_by(params[:album_id])
    @album_music = AlbumMusic.find_by(params[:album_music_id])
    @comment = MusicComment.new(music_comment_params)
    @comment.listener_id = current_listener.id
    @comment.album_id = @album.id
    @comment.album_music_id = @album_music.id
    @comment.save

    # reply_create.jsへ送る用 非同期通信
    @comments = MusicComment.where(reply_comment: @comment.reply_comment)
    @music_comment_n = MusicComment.new
    @music_comment = MusicComment.find_by(id: @comment.reply_comment)
  end

  def reply_destroy
    @album = Album.find_by(params[:album_id])
    @album_music = AlbumMusic.find_by(params[:album_music_id])
    @music_comment = MusicComment.find_by(album_id: @album.id, album_music_id: @album_music.id,id: params[:id])
    @music_comment.destroy

    # reply_create.jsへ送る用 非同期通信
    @reply_comment = @music_comment.reply_comment
    @comments = MusicComment.where(reply_comment: @reply_comment)
    @music_comment_n = MusicComment.new
    @music_comment = Music_comment.find(id: @reply_comment)
  end



  private

  def music_comment_params
    params.require(:music_comment).permit(:listener_id, :album_id, :album_music_id, :comment, :rate)
  end
end
