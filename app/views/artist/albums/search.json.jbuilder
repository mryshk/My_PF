json.array! @search do |post|
  json.id post.id
  json.post_tweet post.post_tweet
  json.name post.listener.name
  json.image post.listener.profile_image
end