json.array! @search do |album|
  json.id album.id
  json.name album.name
  json.creater album.creater.id
  json.creater_name album.creater.listener.name
  json.caption album.caption
end