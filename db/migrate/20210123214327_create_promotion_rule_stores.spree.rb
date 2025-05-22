# frozen_string_literal: true
# This migration comes from spree (originally 20180202190713)

class CreatePromotionRuleStores < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_promotion_rules_stores do |t|
      t.references :store, null: false
      t.references :promotion_rule, null: false

      t.timestamps
    end
  end
end

# touched on 2025-05-22T21:30:33.463798Z
# touched on 2025-05-22T23:47:10.575109Z