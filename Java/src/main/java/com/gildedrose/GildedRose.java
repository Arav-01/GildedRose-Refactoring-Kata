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
                increaseQuality(item, 1);
            } else if (item.name.equals(BACKSTAGE_PASSES)) {
                increaseQuality(item, 1);
                if (item.sellIn <= 10) {
                    increaseQuality(item, 1);
                    if (item.sellIn <= 5) {
                        increaseQuality(item, 1);
                    }
                }
            } else {
                degradeQuality(item, 1);
            }

            if (item.sellIn <= 0) {
                if (item.name.equals(AGED_BRIE)) {
                    increaseQuality(item, 1);
                } else if (item.name.equals(BACKSTAGE_PASSES)) {
                    item.quality = 0;
                } else {
                    degradeQuality(item, 1);
                }
            }

            item.sellIn--;
        }
    }

    private static void increaseQuality(Item item, int amount) {
        item.quality = Math.min(item.quality + amount, MAX_QUALITY);
    }

    private static void degradeQuality(Item item, int amount) {
        item.quality = Math.max(item.quality - amount, MIN_QUALITY);
    }
}
