class CreateGroupListeners < ActiveRecord::Migration[5.2]
  def change
    create_table :group_listeners do |t|
      t.integer :listener_id
      t.integer :group_id

      t.timestamps
    end
  end
end
