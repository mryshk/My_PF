ActiveAdmin.register AlbumMusic do
  permit_params :creater_id, :album_id, :name, :caption, :music_url
end
