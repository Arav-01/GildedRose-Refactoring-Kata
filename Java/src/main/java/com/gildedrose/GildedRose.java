package com.gildedrose;

class GildedRose {
    private static final String AGED_BRIE = "Aged Brie";
    private static final String BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert";
    private static final String SULFURAS = "Sulfuras, Hand of Ragnaros";
    private static final int MAX_QUALITY = 50;
    private static final int MIN_QUALITY = 0;

    Item[] items;

    public GildedRose(Item[] items) {
        this.items = items;
    }

    public void updateQuality() {
        for (Item item : items) {
            if (item.name.equals(SULFURAS)) continue;

            if (item.name.equals(AGED_BRIE)) {
                incrementItemQuality(item);
            } else if (item.name.equals(BACKSTAGE_PASSES)) {
                incrementItemQuality(item);
                if (item.sellIn <= 10) {
                    incrementItemQuality(item);
                    if (item.sellIn <= 5) {
                        incrementItemQuality(item);
                    }
                }
            } else {
                decrementItemQuality(item);
            }

            item.sellIn = item.sellIn - 1;

            if (item.sellIn < 0) {
                if (item.name.equals(AGED_BRIE)) {
                    incrementItemQuality(item);
                } else if (item.name.equals(BACKSTAGE_PASSES)) {
                    item.quality = 0;
                } else {
                    decrementItemQuality(item);
                }
            }
        }
    }

    private static void incrementItemQuality(Item item) {
        if (item.quality < MAX_QUALITY) {
            item.quality++;
        }
    }

    private static void decrementItemQuality(Item item) {
        if (item.quality > MIN_QUALITY) {
            item.quality--;
        }
    }
}
