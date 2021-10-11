ActiveAdmin.register Notification do
  permit_params :post_id, :active_id, :passive_id, :post_comment_id, :action, :checked
end
