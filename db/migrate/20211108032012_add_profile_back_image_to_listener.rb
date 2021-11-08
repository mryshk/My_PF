class AddProfileBackImageToListener < ActiveRecord::Migration[5.2]
  def change
    add_column :listeners, :profile_back_image_id, :string
  end
end
