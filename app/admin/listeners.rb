ActiveAdmin.register Listener do
  permit_params :email, :password, :name, :caption, :profile_image_id, :uid, :provider, :listener_type
end
