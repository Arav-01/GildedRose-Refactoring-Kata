require_relative 'item'

class ItemQualityUpdater

  # Non-special items decrease 1-fold until sell_in time is up, then decrease 2-fold
  def self.update_normal(item)
    amount_to_decrease = item.sell_in <= 0 ? 2 : 1
		item.degrade_quality(amount_to_decrease)
  end

  # Wine items quality increases 2-fold if sell_in time is up, else increases 1-fold
  def self.update_wine(wine)
    amount_to_increase = wine.sell_in <= 0 ? 2 : 1
    wine.increase_quality(amount_to_increase)
  end

  def self.update_ticket(ticket)
    if ticket.sell_in <= 0
      ticket.quality = 0 # Tickets expire if sell_in time is up (concert is over)
    else
      # Ticket price increases 3-fold if <= 5 days left, 2-fold if <= 10 day, 1-fold otherwise
      amount_to_increase = ticket.sell_in <= 5 ? 3
                         : ticket.sell_in <= 10 ? 2
                         : 1
      ticket.increase_quality(amount_to_increase)
    end
  end
end
