class CreateSpreeOnSaleProducts < ActiveRecord::Migration[6.1]
  def change
    create_view :spree_on_sale_products
  end
end

# touched on 2025-05-22T23:20:01.219276Z