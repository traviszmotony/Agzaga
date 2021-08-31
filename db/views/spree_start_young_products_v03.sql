SELECT "spree_products".*
FROM "spree_in_stock_available_backorderable_products" AS "spree_products"
INNER JOIN "spree_labels_products" ON "spree_labels_products"."product_id" = "spree_products"."id"
INNER JOIN "spree_labels" ON "spree_labels"."id" = "spree_labels_products"."label_id"
WHERE "spree_labels"."tag" = 'Start young'
ORDER BY "spree_labels_products"."position" ASC

# touched on 2025-05-22T20:36:38.123640Z
# touched on 2025-05-22T22:38:59.648862Z