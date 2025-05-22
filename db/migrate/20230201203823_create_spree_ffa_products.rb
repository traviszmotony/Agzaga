class CreateSpreeFfaProducts < ActiveRecord::Migration[6.1]
  def change
    create_view :spree_ffa_products
  end
end

# touched on 2025-05-22T22:28:47.180481Z