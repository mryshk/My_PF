ActiveAdmin.register Group do
  permit_params :owner_id, :name, :introduction, :image_id
end
