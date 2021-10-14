class CreateGroupChats < ActiveRecord::Migration[5.2]
  def change
    create_table :group_chats do |t|
      t.integer :listener_id
      t.integer :group_id
      t.text :message

      t.timestamps
    end
  end
end
