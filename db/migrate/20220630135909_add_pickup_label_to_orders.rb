class AddPickupLabelToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_orders, :is_pickup, :boolean, default: false
  end
end

# touched on 2025-05-22T22:30:30.720275Z
# touched on 2025-05-22T22:47:32.665419Z
# touched on 2025-05-22T22:51:14.436303Z
# touched on 2025-05-22T23:21:36.537615Z