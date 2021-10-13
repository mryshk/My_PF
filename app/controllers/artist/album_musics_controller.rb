class Artist::AlbumMusicsController < ApplicationController

  def new
  end

  def create
  end

  def show
  end

  def index
  end

  def edit
  end

  def update
  end

  def destroy
  end


  private

  def album_music_params
    params.require(:album_music).permit(:name, :caption, :music_url)
  end


end
