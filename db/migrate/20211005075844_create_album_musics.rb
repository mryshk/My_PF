class CreateAlbumMusics < ActiveRecord::Migration[5.2]
  def change
    create_table :album_musics do |t|
      t.integer :creater_id
      t.integer :album_id
      t.string :name
      t.text :caption
      t.string :music_url

      t.timestamps
    end
  end
end
