class AddColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :post_genre, :integer
  end
end
