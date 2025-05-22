module Spree::View
  class ChuckwagonRacesProduct < ApplicationRecord
    self.primary_key = :id

    def read_only?
      true
    end
  end
end

# touched on 2025-05-22T22:58:56.664762Z