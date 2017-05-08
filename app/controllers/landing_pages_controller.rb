class LandingPagesController < ApplicationController
  def home
    gem_to_coins_url = 'https://api.guildwars2.com/v2/commerce/exchange/gems?quantity=100'
    @gem_exchange_for_coins = JSON.parse(RestClient.get(gem_to_coins_url))

    coin_to_gems_url = 'https://api.guildwars2.com/v2/commerce/exchange/coins?quantity=100000'
    @coin_exchange_for_gems = JSON.parse(RestClient.get(coin_to_gems_url))

    # conditional for testing
    if !Rails.env.test?
      legendary_items = Item.where(rarity: 7, type_id: 18)
      legendary_item_ids = legendary_items.map(&:item_id)
      items_base_url = 'https://api.guildwars2.com/v2/items?ids='
      legendary_items_url = items_base_url + legendary_item_ids.join(',')
      @legendary_items = JSON.parse(RestClient.get(legendary_items_url))

      trading_post_base_url = 'https://api.guildwars2.com/v2/commerce/listings?ids='
      trading_post_legendaries_url = trading_post_base_url + legendary_item_ids.join(',')
      @legendary_trading_post_prices = JSON.parse(RestClient.get(trading_post_legendaries_url))
    end
  end
end
