class CreateSpreeSaveItems < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_save_items do |t|
      t.integer :user_id
      t.integer :variant_id
      t.integer :quantity
      t.index [:user_id, :variant_id], name: "spree_user_variant_join_index", unique: true
      t.timestamps
    end
  end
end

# touched on 2025-05-22T19:22:26.007597Z
# touched on 2025-05-22T23:37:30.947503Z