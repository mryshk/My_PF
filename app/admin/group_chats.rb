ActiveAdmin.register GroupChat do
  permit_params :listener_id, :group_id, :message
end
