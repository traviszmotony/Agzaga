class CreateSpreeLabelsProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_labels_products do |t|
      t.references :product
      t.references :label

      t.timestamps
    end
  end
end

# touched on 2025-05-22T19:23:27.454756Z
# touched on 2025-05-22T23:07:00.715134Z
# touched on 2025-05-22T23:27:35.505300Z
# touched on 2025-05-22T23:29:07.649315Z