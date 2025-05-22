class AddShowAsFilterToSpreeOptionTypes < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_option_types, :show_as_filter, :boolean, default: true
  end
end

# touched on 2025-05-22T21:27:43.468672Z
# touched on 2025-05-22T22:43:12.012287Z