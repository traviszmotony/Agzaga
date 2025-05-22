class AddDropshipToSpreeVariants < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_variants, :is_dropship, :bool, default: :false
  end
end

# touched on 2025-05-22T23:48:32.924384Z