class Artist::AlbumMusicsController < ApplicationController
  # 権限確認（cancancan）
  authorize_resource

  def new
    @album_music = AlbumMusic.new
  end

  def create
    @album = Album.find_by(id: params[:album_id])
    @album_music = AlbumMusic.new(album_music_params)
    @album_music.album_id = @album.id
    @album_music.creater_id = current_listener.creater.id
    @album_music.listener_id = current_listener.id
    if @album_music.save
      redirect_to artist_album_album_music_path(@album, @album_music)
    else
      render :new
    end
  end

  def show
    @album_music = AlbumMusic.find_by(id: params[:id])
    @album = Album.find_by(id: params[:album_id])
    @music_comment = MusicComment.new
    # 楽曲に対するコメント一覧 リプライコメントは除く。
    @music_comments = MusicComment.where(album_id: @album.id, album_music_id: @album_music.id, reply_comment: nil).all
    @favorite = MusicFavorite.find_by(album_id: @album.id, album_music_id: @album_music.id, listener_id: current_listener.id)
    # 閲覧数カウントされるための記述
    impressionist(@album_music, nil)
    # LinkpreviewのKeyを環境変数として使用するための定義。gem/gonを使用。
    gon.linkpreview_key = ENV['LINKPREVIEW_KEY']
    gon.url = @album_music.music_url
  end

  def edit
    @album = Album.find_by(id: params[:album_id])
    @album_music = AlbumMusic.find(params[:id])
  end

  def update
    @album = Album.find_by(id: params[:album_id])
    @album_music = AlbumMusic.find_by(album_id: params[:album_id], id: params[:id])
    @album_music.listener_id = current_listener.id
    if @album_music.update(album_music_params)
      redirect_to artist_album_album_music_path(@album, @album_music)
    else
      render :edit
    end
  end

  def destroy
    @album = Album.find_by(id: params[:album_id])
    @album_music = AlbumMusic.find_by(album_id: @album.id, id: params[:id])
    @album_music.destroy
    redirect_to artist_album_path(@album)
  end

  private

  def album_music_params
    params.require(:album_music).permit(:name, :caption, :music_url, :listener_id)
  end
end
