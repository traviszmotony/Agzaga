class AddSlugToSpreeProductCard < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_product_cards, :slug, :string
  end
end

# touched on 2025-05-22T21:57:34.252688Z
# touched on 2025-05-22T23:27:19.631525Z