ActiveAdmin.register PostComment do
  permit_params :listener_id, :post_id, :comment
end
