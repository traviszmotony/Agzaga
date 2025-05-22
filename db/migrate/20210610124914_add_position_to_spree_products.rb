class AddPositionToSpreeProducts < ActiveRecord::Migration[6.1]
  def up
    add_column :spree_products, :position, :integer
  end

  def down
    remove_column :spree_products, :position
  end
end

# touched on 2025-05-22T20:40:47.339231Z
# touched on 2025-05-22T22:44:54.835455Z
# touched on 2025-05-22T23:06:35.603776Z