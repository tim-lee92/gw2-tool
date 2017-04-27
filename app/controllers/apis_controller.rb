class ApisController < ApplicationController
  def testing
    url = 'https://api.guildwars2.com/v2/commerce/listings/'
    item_number = 1992
    listing = RestClient.get(url + item_number.to_s)
    @listing = JSON.parse(listing)

    about_url = 'https://api.guildwars2.com/v2/items/'
    item = RestClient.get(about_url + item_number.to_s)
    @item = JSON.parse(item)
  end
end
