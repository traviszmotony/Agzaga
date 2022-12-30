class EmptyAbandonedOrdersTask
  include Sidekiq::Worker

  def perform
    Spree::Order.with_incomplete_order_eight_days.each do |order|
      order.update(state: 'address') if order.state == 'delivery'
      order.empty!
    end
  end
end

# touched on 2025-05-22T19:22:35.472557Z
# touched on 2025-05-22T23:20:01.218623Z