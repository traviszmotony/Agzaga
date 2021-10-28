module Spree::View
  class OnSaleProductsOrderByStaffPicks < ApplicationRecord
    self.primary_key = :id

    def read_only?
      true
    end
  end
end

# touched on 2025-05-22T21:57:24.039778Z
# touched on 2025-05-22T22:45:34.208201Z