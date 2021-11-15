class CreateCreaters < ActiveRecord::Migration[5.2]
  def change
    create_table :creaters do |t|
      t.timestamps
    end
  end
end
