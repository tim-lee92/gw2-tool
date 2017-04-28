class LandingPagesController < ApplicationController
  def home
    gem_to_coins_url = 'https://api.guildwars2.com/v2/commerce/exchange/gems?quantity=100'
    @gem_exchange_for_coins = JSON.parse(RestClient.get(gem_to_coins_url))
    coin_to_gems_url = 'https://api.guildwars2.com/v2/commerce/exchange/coins?quantity=100000'
    @coin_exchange_for_gems = JSON.parse(RestClient.get(coin_to_gems_url))
  end
end
