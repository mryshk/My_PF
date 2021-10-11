ActiveAdmin.register Post do
  permit_params :listener_id, :post_url, :post_tweet, :picture_id, :impressions_count
end
