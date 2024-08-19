SELECT spree_on_sale_products.id
  FROM spree_on_sale_products
    LEFT JOIN (SELECT spree_on_sale_products.id
      FROM spree_on_sale_products
    LEFT OUTER JOIN spree_labels_products
      ON spree_labels_products.product_id = spree_on_sale_products.id
    LEFT OUTER JOIN spree_labels
      ON spree_labels.id = spree_labels_products.label_id
  WHERE spree_labels.tag = 'Staff Pick') AS p
ON spree_on_sale_products.id = p.id ORDER BY P.id;

# touched on 2025-05-22T23:30:31.502057Z
# touched on 2025-05-22T23:47:02.122630Z