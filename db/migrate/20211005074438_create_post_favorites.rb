class CreatePostFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :post_favorites do |t|
      t.integer :listener_id
      t.integer :post_id

      t.timestamps
    end
  end
end
