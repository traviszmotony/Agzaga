module Models
  module Spree
    module TaxonDecorator
      def self.prepended(base)
        base.class_eval do
          include TimeZoneVariation

          before_save -> { time_zone_variation(:small_ads_end_at, :large_ads_end_at) }, if: -> { self.changed? }
        end
      end

      ::Spree::Taxon.prepend self
    end
  end
end

# touched on 2025-05-22T23:10:02.481798Z
# touched on 2025-05-22T23:44:20.109119Z
# touched on 2025-05-22T23:46:31.327288Z