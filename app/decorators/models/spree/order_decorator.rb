module Models
  module Spree
    module OrderDecorator
      def self.prepended(base)
        base.checkout_flow do
          go_to_state :address
          go_to_state :payment
        end

        base.class_eval do
          has_many :custom_hose_configurations, dependent: :destroy
          after_create :set_abandoned_cart_email_job

          after_update :create_shipments
          after_update :update_abandoned_cart_email_job
          after_update :schedule_review_email_job, if: :saved_change_to_shipment_state?

          has_one :pick_up_person
          accepts_nested_attributes_for :pick_up_person

          scope :with_incomplete_order_seven_days, -> do
            where("updated_at >= ? AND updated_at <= ?", 7.days.ago.to_time.beginning_of_day, 7.days.ago.to_time.end_of_day)
            .where("state IN (?)", ["cart", "address", "payment", "delivery", "confirm"])
          end

          scope :with_incomplete_order_eight_days, -> do
            where("updated_at >= ? AND updated_at <= ?", 8.days.ago.to_time.beginning_of_day, 8.days.ago.to_time.end_of_day)
            .where("state IN (?)", ["cart", "address", "payment", "delivery", "confirm"])
          end

          def create_shipments
            return unless (['cart', 'address'].include?(self.state) && self.shipments.blank? && self.line_items.any?)
            self.create_proposed_shipments
            self.recalculate
          end

          def ensure_shipping_address
            if !self.pick_up_order?
              unless ship_address && ship_address.valid?
                errors.add(:base, I18n.t('spree.ship_address_required')) && (return false)
              end
            end
          end

          def set_abandoned_cart_email_job
            if self.line_items.present? && self.email.present?
              SetAbandonedCartEmailJob.set(wait: 1.hour).perform_later(self, "1hour")
              SetAbandonedCartEmailJob.set(wait: 24.hours).perform_later(self, "24hours")
            end
          end

          def update_abandoned_cart_email_job
            queue = Sidekiq::ScheduledSet.new
            queue.each do |job|
              if job&.args[0]["arguments"][0] == {"_aj_globalid"=>"gid://agazon/Spree::Order/#{self.id}"} && job&.args[0]["job_class"] == "SetAbandonedCartEmailJob"
                job.delete
              end
            end

            in_processable_states = !['complete', 'returned'].include?(self.state)
            if self.line_items.present? && in_processable_states && self.email.present?
              SetAbandonedCartEmailJob.set(wait: 1.hour).perform_later(self, "1hour")
              SetAbandonedCartEmailJob.set(wait: 24.hours).perform_later(self, "24hours")
            end
          end

          def schedule_review_email_job
            SendReviewEmailJob.set(wait: 7.days).perform_later(self) if shipment_state == "shipped"
          end

          def empty!
            line_items.destroy_all
            adjustments.destroy_all
            shipments.destroy_all
            order_promotions.destroy_all
            custom_hose_configurations.destroy_all

            recalculate
          end

          def pick_up_order?
            self.is_pickup == true ? true : false
          end
        end
      end

      ::Spree::Order.prepend self
    end
  end
end

# touched on 2025-05-22T22:30:33.728019Z
# touched on 2025-05-22T23:36:49.761748Z