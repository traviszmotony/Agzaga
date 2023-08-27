class CreateNetSuiteEbaySalesOrderJob < ApplicationJob
  queue_as :netsuite
  sidekiq_options retry: false

  def perform(order_id)
    ebay_order_data = Ebay::EbayOrderData.new.get_order_data(order_id)

    NetSuite::EbaySalesOrder.new.create(order_id, ebay_order_data)
  end
end

# touched on 2025-05-22T20:41:06.630533Z
# touched on 2025-05-22T20:44:29.430495Z
# touched on 2025-05-22T23:29:10.415036Z