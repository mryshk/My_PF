class AddImpressionsCountToAlbums < ActiveRecord::Migration[5.2]
  def change
    add_column :albums, :impressions_count, :integer, default: 0
  end
end
