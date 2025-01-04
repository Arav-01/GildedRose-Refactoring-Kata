require_relative 'item_categorizer'
require_relative 'item_quality_updater'

class Item
	MAX_QUALITY = 50
	MIN_QUALITY = 0

	attr_accessor :name, :sell_in, :quality, :isConjured

	def initialize(name, sell_in, quality, isConjured = false)
		@name = name
		@sell_in = sell_in
		@quality = quality
		@isConjured = isConjured
	end

	def update_quality()
		category = ItemCategorizer.categorize(self)

		# Legendary quality items remain constant at 80 - no update required))
		return if category == ItemCategorizer::LEGENDARY;

		if category == ItemCategorizer::WINE
			ItemQualityUpdater.update_wine(self)
		elsif category == ItemCategorizer::TICKET
			ItemQualityUpdater.update_ticket(self)
		else
			ItemQualityUpdater.update_normal(self)
		end
	end

	def increase_quality(amount)
		# Make sure quality dosen't exceed max quality allowed
		@quality = [@quality + amount, MAX_QUALITY].min
	end
	
	def degrade_quality(amount)
		if self.isConjured
			amount *= 2
		end
		# Make sure quality dosen't go under min quality allowed
		@quality = [@quality - amount, MIN_QUALITY].max
	end

	def is_conjured()
		# Currently taking boolean in constructor to identify conjured item
		# ToDo: Implement logic for determining whether item is conjured
		raise "Not Implemented: Don't know the logic determing conjured items"
	end

	def to_s()
		"Name:#{@name}, SellTime:#{@sell_in}, Quality:#{@quality}"
	end
end