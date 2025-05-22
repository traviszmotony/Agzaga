class CreateFfaFundraiserEvent < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_ffa_fundraiser_events do |t|
      t.boolean :is_active, default: false
      t.integer :started_by_id, null: true
      t.integer :ended_by_id, null: true
      t.datetime :ended_at
      t.timestamps
    end
  end
end

# touched on 2025-05-22T22:32:48.583635Z