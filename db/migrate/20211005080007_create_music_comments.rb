class CreateMusicComments < ActiveRecord::Migration[5.2]
  def change
    create_table :music_comments do |t|
      t.integer :creater_id
      t.integer :album_id
      t.integer :album_music_id
      t.text :comment
      t.float :rate

      t.timestamps
    end
  end
end
