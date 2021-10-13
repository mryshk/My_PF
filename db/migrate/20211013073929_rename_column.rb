class RenameColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :music_comments, :creater_id, :listener_id
    rename_column :music_favorites, :creater_id, :listener_id
  end
end
