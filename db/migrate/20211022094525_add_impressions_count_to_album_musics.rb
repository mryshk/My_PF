class AddImpressionsCountToAlbumMusics < ActiveRecord::Migration[5.2]
  def change
    add_column :album_musics, :impressions_count, :integer, default: 0
  end
end
