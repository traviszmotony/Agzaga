module Spree::View
  class ChuckwagonRacesProduct < ApplicationRecord
    self.primary_key = :id

    def read_only?
      true
    end
  end
end

# touched on 2025-05-22T22:58:56.664762Z
# touched on 2025-05-22T23:29:10.408301Z
# touched on 2025-05-22T23:46:31.322384Z