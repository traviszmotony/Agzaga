class CreateSpreeEbayLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_ebay_logs do |t|
      t.text :response
      t.integer :status_code
      t.string :order_id

      t.timestamps
    end
  end
end

# touched on 2025-05-22T20:34:28.338091Z
# touched on 2025-05-22T20:38:05.168867Z
# touched on 2025-05-22T22:55:21.882859Z