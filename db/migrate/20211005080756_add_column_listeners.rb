class AddColumnListeners < ActiveRecord::Migration[5.2]
  def change
    add_column :listeners, :name, :string
    add_column :listeners, :caption, :text
    add_column :listeners, :profile_image_id, :string
    add_column :listeners, :uid, :string
    add_column :listeners, :provider, :string
  end
end
