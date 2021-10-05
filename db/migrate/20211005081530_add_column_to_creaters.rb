class AddColumnToCreaters < ActiveRecord::Migration[5.2]
  def change
    add_column :creaters, :name, :string
    add_column :creaters, :caption, :text
    add_column :creaters, :profile_image_id, :string
    add_column :creaters, :creater_url, :string
    add_column :creaters, :uid, :string
    add_column :creaters, :provider, :string
  end
end
