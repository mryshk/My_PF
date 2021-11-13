class AddListenerIdToAlbumMusics < ActiveRecord::Migration[5.2]
  def change
    add_column :album_musics, :listener_id, :integer
  end
end
