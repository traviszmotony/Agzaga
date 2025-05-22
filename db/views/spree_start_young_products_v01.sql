SELECT "spree_products".*
FROM "spree_in_stock_available_products" AS "spree_products"
INNER JOIN "spree_labels_products" ON "spree_labels_products"."product_id" = "spree_products"."id"
INNER JOIN "spree_labels" ON "spree_labels"."id" = "spree_labels_products"."label_id"
WHERE "spree_labels"."tag" = 'Start young'

# touched on 2025-05-22T20:45:00.352096Z
# touched on 2025-05-22T22:52:34.822028Z
# touched on 2025-05-22T23:41:22.558257Z