module Spree
  class CustomHoseGeneratorController < Spree::StoreController
    def index
      @custom_hose_variants = Spree::Product.where(product_type: 'custom_hose').last.variants
      @hose_fittings = Spree::Product.where(product_type: 'hose_fitting').last.variants
      @hose_assembly_fee = Spree::Product.where(product_type: 'assembly_fee').last
    end
  end
end

# touched on 2025-05-22T19:10:18.063257Z
# touched on 2025-05-22T19:21:56.989470Z
# touched on 2025-05-22T23:25:38.932625Z