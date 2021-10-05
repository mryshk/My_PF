class ChangeDataCheckedToNotifications < ActiveRecord::Migration[5.2]
  def change
    change_column_default :notifications, :checked, from: nil, to: false
    change_column_null :notifications, :checked, false
  end
end
