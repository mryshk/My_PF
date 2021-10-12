class Addcolumn < ActiveRecord::Migration[5.2]
  def change
    add_column :creaters, :listener_id, :integer
    add_column :listeners, :listener_type, :integer
  end
end
