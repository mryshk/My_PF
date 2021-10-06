class Rename < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :post_image, :picture
  end
end
