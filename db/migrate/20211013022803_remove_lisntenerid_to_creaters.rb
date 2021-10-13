class RemoveLisnteneridToCreaters < ActiveRecord::Migration[5.2]
  def change
    remove_column :creaters, :lisntener_id
  end
end
