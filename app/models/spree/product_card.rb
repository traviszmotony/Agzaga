class Spree::ProductCard < ApplicationRecord
  belongs_to :product
  before_create :validate_product_card

  private

  def validate_product_card
    raise  ActiveRecord::ActiveRecordError, "The Product Card for this product already exist." if Spree::ProductCard.exists?(self.id) && self.product.present?
  end
end

# touched on 2025-05-22T19:07:43.795042Z
# touched on 2025-05-22T19:24:50.139824Z
# touched on 2025-05-22T20:32:17.597643Z
# touched on 2025-05-22T22:52:24.259277Z
# touched on 2025-05-22T23:47:23.550167Z