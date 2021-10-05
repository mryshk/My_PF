class CreateMusicFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :music_favorites do |t|
      t.integer :creater_id
      t.integer :album_id
      t.integer :album_music_id

      t.timestamps
    end
  end
end
