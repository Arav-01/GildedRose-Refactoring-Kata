class GildedRose

  SULFURAS = "Sulfuras, Hand of Ragnaros"
  AGED_BRIE = "Aged Brie"
  BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"
  MAX_QUALITY = 50
  MIN_QUALITY = 0

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      # Sulfuras is legendary (quality remains constant at 80 - no update required))
      next if item.name == SULFURAS;

      if item.name == AGED_BRIE
        # Aged Brie increases 2-fold if sell_in time is up, else increase 1-fold
        amount_to_increase = item.sell_in <= 0 ? 2 : 1
        increase_quality(item, amount_to_increase)

      elsif item.name == BACKSTAGE_PASSES
        if item.sell_in <= 0
          # Backstage passes expire if sell_in time is up (concert is over)
          item.quality = 0
        else
          # Backstage passes increase 3-fold if <= 5 days left, 2-fold if <= 10 day, 1-fold otherwise
          amount_to_increase = item.sell_in <= 5 ? 3
                             : item.sell_in <= 10 ? 2
                             : 1;
          increase_quality(item, amount_to_increase)
        end

      else
        # Non-special items decrease 1-fold until sell_in time is up, then decrease 2-fold
        amount_to_decrease = item.sell_in <= 0 ? 2 : 1;
        degrade_quality(item, amount_to_decrease)
      end

      item.sell_in -= 1
    end
  end

  def increase_quality(item, amount)
    # Make sure quality dosen't exceed max quality allowed
    item.quality = [item.quality + amount, MAX_QUALITY].min
  end

  def degrade_quality(item, amount)
=begin
Tests are not working for "Conjured" items.
↓Code is written for conjured items degrading twice as fast↓
    if /Conjured/i.match?(item.name)
      amount *= 2
    end
=end
    # Make sure quality dosen't go under min quality allowed
    item.quality = [item.quality - amount, MIN_QUALITY].max
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
