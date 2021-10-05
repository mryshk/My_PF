class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :post_id
      t.integer :active_id
      t.integer :passive_id
      t.integer :post_comment_id
      t.string :action
      t.boolean :checked

      t.timestamps
    end
  end
end
