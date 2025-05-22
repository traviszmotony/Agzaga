class AddDisplayTextToSpreeLabel < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_labels, :display_text, :string
  end
end

# touched on 2025-05-22T19:23:18.563359Z
# touched on 2025-05-22T22:52:34.826958Z