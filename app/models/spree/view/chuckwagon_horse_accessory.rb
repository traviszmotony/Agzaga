module Spree::View
  class ChuckwagonHorseAccessory < ApplicationRecord
    self.primary_key = :id

    def read_only?
      true
    end
  end
end

# touched on 2025-05-22T20:44:58.448740Z
# touched on 2025-05-22T22:33:03.341280Z