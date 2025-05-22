class UpdateSpreeSiteWideDealsToVersion2 < ActiveRecord::Migration[6.1]
  def change
    update_view :spree_site_wide_deals, version: 2, revert_to_version: 1
  end
end

# touched on 2025-05-22T22:38:30.443539Z