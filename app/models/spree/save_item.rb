module Spree

  class SaveItem < ApplicationRecord
    belongs_to :user, class_name: 'Spree::User'
    belongs_to :variant, class_name: 'Spree::Variant'
  end
end

# touched on 2025-05-22T19:22:31.453995Z
# touched on 2025-05-22T20:44:27.504151Z
# touched on 2025-05-22T21:51:09.267531Z
# touched on 2025-05-22T22:32:15.382429Z
# touched on 2025-05-22T22:55:19.249117Z
# touched on 2025-05-22T23:27:51.821184Z