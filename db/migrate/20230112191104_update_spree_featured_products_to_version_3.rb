class UpdateSpreeFeaturedProductsToVersion3 < ActiveRecord::Migration[6.1]
  def change
    update_view :spree_featured_products, version: 3, revert_to_version: 2
  end
end

# touched on 2025-05-22T22:38:51.644024Z