class RenameStatusToReponse < ActiveRecord::Migration[6.1]
  def change
    rename_column :spree_net_suite_logs, :status, :response
    add_column :spree_net_suite_logs, :status_code, :integer
  end
end

# touched on 2025-05-22T23:37:13.126590Z