require_relative 'item_categorizer'

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

		# Wine items quality increases 2-fold if sell_in time is up, else increases 1-fold
		if category == ItemCategorizer::WINE
			amount_to_increase = @sell_in <= 0 ? 2 : 1
			self.increase_quality(amount_to_increase)

		elsif category == ItemCategorizer::TICKET
			if @sell_in > 0
				# Ticket price increases 3-fold if <= 5 days left, 2-fold if <= 10 day, 1-fold otherwise
				amount_to_increase = @sell_in <= 5 ? 3
								   : @sell_in <= 10 ? 2
								   : 1;
				self.increase_quality(amount_to_increase)
			else
				@quality = 0 # Tickets expire if sell_in time is up (concert is over)
			end

		# Non-special items decrease 1-fold until sell_in time is up, then decrease 2-fold
		else
			amount_to_decrease = @sell_in <= 0 ? 2 : 1;
			self.degrade_quality(amount_to_decrease)
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