# frozen_string_literal: true
# This migration comes from solidus_tax_cloud (originally 20121220192438)

class CreateSpreeTaxCloudTransactions < ActiveRecord::Migration[4.2]
  def change
    create_table :spree_tax_cloud_transactions do |t|
      t.references :order
      t.string :message

      t.timestamps null: false
    end
    add_index :spree_tax_cloud_transactions, :order_id
  end
end

# touched on 2025-05-22T21:33:39.214040Z
# touched on 2025-05-22T22:51:23.578820Z