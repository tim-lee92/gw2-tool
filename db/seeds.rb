require 'rest-client'
require 'json'

items_id_url = 'https://www.gw2spidy.com/api/v0.9/json/all-items/all'
items_array = JSON.parse(RestClient.get(items_id_url))['results']

items_array.each do |item|
  Item.create(
    item_id: item['data_id'],
    name: item['name'],
    image: item['img'],
    rarity: item['rarity'],
    min_level: item['restriction_level'],
    type_id: item['type_id'],
    sub_type_id: item['sub_type_id']
  )
end
