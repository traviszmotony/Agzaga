class AddPickupLabelToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_orders, :is_pickup, :boolean, default: false
  end
end

# touched on 2025-05-22T22:30:30.720275Z