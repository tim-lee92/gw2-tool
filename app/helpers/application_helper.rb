module ApplicationHelper
  def format_coins(num)
    coins = convert_to_coins(num)
    string = "#{coins[:gold]}<i class=\"gw2_gold\">g</i> #{coins[:silver]}<i class=\"gw2_silver\">s</i>"
    if !coins[:copper]
      string
    else
      string += " #{coins[:copper]}<i class=\"gw2_copper\">c</i>"
      string
    end
  end

  def convert_to_coins(num)
    gold = num / 10000
    silver = num % 10000 / 100
    copper = num % 100

    { gold: gold, silver: silver, copper: copper}
  end
end
