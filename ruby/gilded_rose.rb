require_relative 'item'

class GildedRose

  def initialize(items)
    @items = items
  end

  def update_inventory()
    @items.each do |item|
      item.update_quality()
      item.sell_in -= 1
    end
  end

end
