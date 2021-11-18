class AddReplyCommentToMusicComment < ActiveRecord::Migration[5.2]
  def change
    add_column :music_comments, :reply_comment, :integer
  end
end
