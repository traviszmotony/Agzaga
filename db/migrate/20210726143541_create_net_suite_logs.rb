class CreateNetSuiteLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_net_suite_logs do |t|
      t.text :status
      t.references :order

      t.timestamps
    end
  end
end

# touched on 2025-05-22T19:09:48.537400Z
# touched on 2025-05-22T19:16:22.559632Z
# touched on 2025-05-22T19:18:03.149840Z
# touched on 2025-05-22T19:24:28.534464Z
# touched on 2025-05-22T22:47:11.773834Z
# touched on 2025-05-22T23:25:41.493734Z