module Models
  module SolidusPaypalCommercePlatform
    module PaypalAddressDecorator
      def self.prepended(base)
        base.class_eval do
          def simulate_update(paypal_address)
            @order.update(ship_address: format_simulated_address(paypal_address))

            return unless @order.ship_address.valid?


            #@order.ensure_updated_shipments
            @order.email = "info@solidus.io" unless @order.email
            @order.contents.advance
          end
        end
      end

      ::SolidusPaypalCommercePlatform::PaypalAddress.prepend self
    end
  end
end

# touched on 2025-05-22T20:37:28.668027Z
# touched on 2025-05-22T22:29:59.250391Z
# touched on 2025-05-22T23:28:43.833374Z