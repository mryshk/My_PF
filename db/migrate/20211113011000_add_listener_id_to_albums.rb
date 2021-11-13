class AddListenerIdToAlbums < ActiveRecord::Migration[5.2]
  def change
    add_column :albums, :listener_id, :integer
  end
end
