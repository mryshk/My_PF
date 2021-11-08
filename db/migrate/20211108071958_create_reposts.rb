class CreateReposts < ActiveRecord::Migration[5.2]
  def change
    create_table :reposts do |t|
      t.integer :listener,foreign_key: true
      t.integer :post, foreign_key: true
      t.timestamps
    end
  end
end
