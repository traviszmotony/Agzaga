class AddAssemblyFeeToCustomHoseConfiguration < ActiveRecord::Migration[6.1]
  def change
    add_column :custom_hose_configurations, :assembly_fee_id, :integer
  end
end

# touched on 2025-05-22T20:38:05.170498Z
# touched on 2025-05-22T22:55:07.795101Z