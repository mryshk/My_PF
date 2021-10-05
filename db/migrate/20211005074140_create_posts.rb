class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :listener_id
      t.string :post_url
      t.text :post_tweet
      t.string :post_image

      t.timestamps
    end
  end
end
