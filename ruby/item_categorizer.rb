class ItemCategorizer
	LEGENDARY = "Legendary"
	WINE = "Wine"
	TICKET = "Ticket"

	SPECIAL_ITEM_CATEGORIES = {
		LEGENDARY => ["Sulfuras, Hand of Ragnaros"],
		WINE => ["Aged Brie"],
		TICKET => ["Backstage passes to a TAFKAL80ETC concert"],
	}.freeze

	def self.categorize(item)
		SPECIAL_ITEM_CATEGORIES.each do |category, items|
			return category if items.include?(item.name)
		end
		"Non-Special Item"
	end
end
 