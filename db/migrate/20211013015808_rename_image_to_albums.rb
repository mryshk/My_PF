class RenameImageToAlbums < ActiveRecord::Migration[5.2]
  def change
    rename_column :albums, :image_id, :album_image_id
  end
end
