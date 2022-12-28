class AbandonedCartEmail
  include Sidekiq::Worker

  def perform(order: nil, seven_day_email: true, time: nil)
    if order.present? && ["cart", "address", "payment", "delivery", "confirm"].include?(order.state) && order.line_items.present?
      if time == '1hour'
        abandoned_cart_notification_email(order,'Abandoned Cart Reminder #1')
      elsif time == "24hours"
        abandoned_cart_notification_email(order,'Abandoned Cart Reminder #2')
      elsif seven_day_email == true
        abandoned_cart_notification_email(order,'Abandoned Cart Reminder #3')
      end
    end
  end

  def abandoned_cart_notification_email(order, subject = 'Abandoned Cart Reminder #1')
    item_content = []

    order.line_items.each do |line_item|
      item_content << {
        "PRODUCT_NAME": line_item.name,
        "IMAGE_SRC": line_item.variant.images.first.try(:url, :small),
        "PRODUCT_PRICE": Spree::Money.new(line_item.price).to_s
      }
    end

    global_merge_vars = [
      { "name": "CURRENT_YEAR", "content": Date.current.year },
      { "name": "COMPANY", "content": "Agzaga" },
      { "name": "PRODUCTS", "content": item_content },
      { "name": "EMAIL", "content": "info@agzaga.com"}
    ]

    email_settings = {
      template_name: subject,
      from_email: order.store.mail_from_address,
      to_email: order.email,
      global_merge_vars: global_merge_vars
    }

    response = Mailchimp::Transactional::SendEmailService.new(email_settings).call
    status = response.is_a?(Array) && response[0].present? && response[0]['status'].present? ? response[0]['status'] : nil
    reject_reason = response.is_a?(Array) && response[0].present? && response[0]['reject_reason'].present? ? response[0]['reject_reason'] : nil
    Spree::EmailLog.create(template_name: subject, subject: subject,
                           sent_from: order.store.mail_from_address, sent_to: order.email,
                           order_id: order.id, status: status, reject_reason: reject_reason)
  end
end

# touched on 2025-05-22T22:49:58.455211Z
# touched on 2025-05-22T23:02:05.774379Z
# touched on 2025-05-22T23:19:58.189389Z