module Spree::View
  class AvailableGiftProduct < ApplicationRecord
    self.primary_key = :id

    has_and_belongs_to_many :products,
              class_name: "Product",
              join_table: :spree_product_groups,
              foreign_key: :group_product_id,
              association_foreign_key: :product_id

    has_one :product_card,
            foreign_key: :product_id

    has_one :master,
      -> { where(is_master: true).with_discarded },
      inverse_of: :product,
      class_name: 'Spree::Variant',
      autosave: true,
      foreign_key: :product_id

    def read_only?
      true
    end
  end
end

# touched on 2025-05-22T22:42:51.983037Z
# touched on 2025-05-22T23:27:25.456752Z
# touched on 2025-05-22T23:44:14.127595Z