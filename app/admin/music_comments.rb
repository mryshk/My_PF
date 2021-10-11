ActiveAdmin.register MusicComment do
  permit_params :creater_id, :album_id, :music_id, :comment, :rate
end
