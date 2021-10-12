class Deletecreaters < ActiveRecord::Migration[5.2]
  def change
    drop_table :creaters
  end
end
