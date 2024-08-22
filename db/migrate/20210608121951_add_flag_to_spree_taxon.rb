class AddFlagToSpreeTaxon < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_taxons, :visibility, :boolean, default: true
  end
end

# touched on 2025-05-22T19:22:45.027927Z
# touched on 2025-05-22T23:47:08.131462Z