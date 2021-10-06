class Public::PostFavoritesController < ApplicationController
  
    def create
        @music = Music.find(params[:music_id])
        @favorite = current_user.favorites.new(music_id: @music.id)
        @favorite.save
    end

    def destroy
        @music = Music.find(params[:music_id])
        @favorite = current_user.favorites.find_by(music_id: @music.id)
        @favorite.destroy
    end
end
