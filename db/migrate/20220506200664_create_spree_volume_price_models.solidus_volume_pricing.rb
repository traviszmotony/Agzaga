# frozen_string_literal: true
# This migration comes from solidus_volume_pricing (originally 20150603143015)

class CreateSpreeVolumePriceModels < ActiveRecord::Migration[4.2]
  def change
    create_table :spree_volume_price_models do |t|
      t.string :name
      t.timestamps
    end

    create_table :spree_variants_volume_price_models do |t|
      t.belongs_to :volume_price_model
      t.belongs_to :variant
    end

    add_reference :spree_volume_prices, :volume_price_model

    add_index :spree_variants_volume_price_models, :volume_price_model_id, name: 'volume_price_model_id'
    add_index :spree_variants_volume_price_models, :variant_id, name: 'variant_id'
  end
end

# touched on 2025-05-22T22:39:03.205399Z