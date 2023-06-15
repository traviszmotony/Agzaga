SELECT "spree_products".*
FROM "spree_avaliable_products" AS "spree_products"
INNER JOIN "spree_labels_products" ON "spree_labels_products"."product_id" = "spree_products"."id"
INNER JOIN "spree_labels" ON "spree_labels"."id" = "spree_labels_products"."label_id"
WHERE "spree_labels"."tag" = 'Upsell Products'
ORDER BY "spree_labels_products"."position" ASC

# touched on 2025-05-22T19:09:48.534327Z
# touched on 2025-05-22T19:16:15.464834Z
# touched on 2025-05-22T21:19:01.078085Z
# touched on 2025-05-22T22:36:06.735672Z
# touched on 2025-05-22T23:27:43.980997Z