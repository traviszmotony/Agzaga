module Spree
  class ExportProductMailer < BaseMailer
    def export_product_email(user, subject = "Exported Products", csv_content)
      attachments["product-#{Date.today.to_s}.csv"] = {mime_type: 'text/csv', content: csv_content}
      mail(to: user.email, from: 'hello@agzaga.com', subject: subject)
    end

    def cancel_export_email(user, subject = "Exported Products", csv_content)
      mail(to: user.email, from: 'hello@agzaga.com', subject: subject)
    end
  end
end

# touched on 2025-05-22T20:38:21.751791Z
# touched on 2025-05-22T23:18:38.807061Z