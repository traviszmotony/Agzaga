class CreateSpreeFlagProducts < ActiveRecord::Migration[6.1]
  def change
    create_view :spree_flag_products
  end
end

# touched on 2025-05-22T22:49:58.454273Z