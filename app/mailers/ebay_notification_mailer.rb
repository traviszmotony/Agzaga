  class EbayNotificationMailer < ApplicationMailer

    def error_email(error)
      @error = error
      subject = "Ebay error hit"
      recipients = ['admin@agzaga.com', 'rcesonis@jonescos.com']
      mail(to: recipients, from: 'hello@agzaga.com', subject: subject)
    end
  end

# touched on 2025-05-22T19:23:50.333946Z
# touched on 2025-05-22T23:08:58.933976Z
# touched on 2025-05-22T23:46:27.767775Z