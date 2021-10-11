ActiveAdmin.register Chat do
  permit_params :listener_id, :room_id, :message
end
