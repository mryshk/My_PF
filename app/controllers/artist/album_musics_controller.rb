class Artist::AlbumMusicsController < ApplicationController

  # 本人確認。 自分以外の人をアクセス不可にするための確認。
  before_action :ensure_listener,only:[:edit,:update,:destroy]
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
  end

  def update
    @album_music.listener_id = current_listener.id
    if @album_music.update(album_music_params)
      redirect_to artist_album_album_music_path(@album, @album_music)
    else
      render :edit
    end
  end

  def destroy
    @album_music.destroy
    redirect_to artist_album_path(@album)
  end

  private

  # 本人確認 本人以外であれば、ホーム画面へ遷移。
  def ensure_listener
    @album = Album.find_by(id: params[:album_id])
    @album_music = AlbumMusic.find_by(album_id: @album.id, id: params[:id])
    if @album_music.listener_id != current_listener.id
      redirect_to home_post_path, alert: '画面を閲覧する権限がありません。'
    end
  end

  def album_music_params
    params.require(:album_music).permit(:name, :caption, :music_url, :listener_id)
  end
end
