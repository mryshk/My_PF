class ChangeColumnDefaultToListeners < ActiveRecord::Migration[5.2]
  def change
    change_column_default :listeners, :listener_type, from: nil, to: 0
  end
end
