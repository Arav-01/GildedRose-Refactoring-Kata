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
      next if item.name == SULFURAS; # Sulfuras is legendary with quality constant 80 (no update required)

      if item.name != AGED_BRIE and item.name != BACKSTAGE_PASSES
        degrade_quality(item, 1)
      else
        increase_quality(item, 1)
        if item.name == BACKSTAGE_PASSES
          if item.sell_in <= 10
            increase_quality(item, 1)
          end
          if item.sell_in <= 5
            increase_quality(item, 1)
          end
        end
      end

      if item.sell_in <= 0
        if item.name != AGED_BRIE
          if item.name != BACKSTAGE_PASSES
            degrade_quality(item, 1)
          else
            item.quality = 0
          end
        else
          increase_quality(item, 1)
        end
      end

      item.sell_in = item.sell_in - 1
    end
  end

  def increase_quality(item, amount)
    item.quality = [item.quality + amount, MAX_QUALITY].min
  end

  def degrade_quality(item, amount)
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
