class CreateFilterTables < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_filter_types do |t|
      t.string :name, limit: 100
      t.string :presentation, limit: 100
      t.integer :position, default: 0, null: false, index: true

      t.timestamps
    end

    create_table :spree_filter_values do |t|
      t.integer :position, default: 0, null: false, index: true
      t.string :name
      t.string :presentation
      t.integer :filter_type_id
      t.index [:filter_type_id], name: "index_spree_filter_types_on_filter_type_id"

      t.timestamps
    end

    create_table :spree_filter_types_products do |t|
      t.integer :product_id
      t.integer :filter_type_id
      t.index [:filter_type_id], name: "index_spree_product_filter_types_on_filter_type_id"
      t.index [:product_id], name: "index_spree_product_filter_types_on_product_id"

      t.timestamps
    end


    create_table :spree_filter_values_products, force: :cascade do |t|
      t.integer :product_id
      t.integer :filter_value_id

      t.index [:filter_value_id], name: "index_spree_product_filter_values_on_filter_value_id"
      t.index [:product_id], name: "index_spree_product_filter_values_on_product_id"

      t.timestamps
    end

  end
end

# touched on 2025-05-22T23:42:51.386410Z
# touched on 2025-05-22T23:43:51.265242Z