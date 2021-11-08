class RenameListener < ActiveRecord::Migration[5.2]
  def change
    rename_column :reposts, :listener, :listener_id
    rename_column :reposts, :post, :post_id
  end
end
