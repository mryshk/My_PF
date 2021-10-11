ActiveAdmin.register Album do
  permit_params :creater_id, :name, :caption, :image_id, :genre, :album_url
end
