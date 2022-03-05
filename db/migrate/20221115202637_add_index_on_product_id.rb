class AddIndexOnProductId < ActiveRecord::Migration[6.1]
  def change
    add_index :spree_product_cards, :product_id, unique: :true
  end
end

# touched on 2025-05-22T22:55:46.262139Z