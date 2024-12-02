require_relative 'item'
require_relative 'item_categorizer'
require_relative 'gilded_rose'

def main()
  items = [
    Item.new("Sulfuras, Hand of Ragnaros", 10, 80),
    Item.new("Aged Brie", 7, 10),
    Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 2),
    Item.new("Some non-special item", 3, 3)
  ]

  show_item_category(items)

  start_gilded_rose(items)
end

def show_item_category(items)
  items.each do |item|
    category = ItemCategorizer.categorize(item)
    puts "\"#{item.name}\" belongs to category: \"#{category}\""
  end
end

def start_gilded_rose(items)
  gilded_rose = GildedRose.new(items);

  day = 1
  all_items_expired = false

  while !all_items_expired
    puts "\nDay #{day}"
    gilded_rose.update_inventory()

    all_items_expired = true
    items.each do |item|
      if (item.sell_in > 0)
        all_items_expired = false
      end

      puts item.to_s()
    end
    day += 1
  end
end

main()
