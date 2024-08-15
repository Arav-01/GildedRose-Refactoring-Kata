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
            switch (item.name) {
                case SULFURAS:
                    continue;

                case AGED_BRIE:
                    if (item.sellIn <= 0) {
                        increaseQuality(item, 2);
                    } else {
                        increaseQuality(item, 1);
                    }
                    break;

                case BACKSTAGE_PASSES:
                    if (item.sellIn <= 0) {
                        item.quality = 0;
                    } else if (item.sellIn <= 5) {
                        increaseQuality(item, 3);
                    } else if (item.sellIn <= 10) {
                        increaseQuality(item, 2);
                    } else {
                        increaseQuality(item, 1);
                    }
                    break;

                default:
                    if (item.sellIn <= 0) {
                        degradeQuality(item, 2);
                    } else {
                        degradeQuality(item, 1);
                    }
                    break;
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
