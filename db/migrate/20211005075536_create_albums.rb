class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.integer :creater_id
      t.string :name
      t.text :caption
      t.string :image_id
      t.integer :genre
      t.string :album_url

      t.timestamps
    end
  end
end
