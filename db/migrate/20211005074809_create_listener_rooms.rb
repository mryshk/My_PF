class CreateListenerRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :listener_rooms do |t|
      t.integer :listener_id
      t.integer :room_id

      t.timestamps
    end
  end
end
