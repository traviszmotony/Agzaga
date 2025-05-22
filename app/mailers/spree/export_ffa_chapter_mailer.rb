module Spree
  class ExportFfaChapterMailer < BaseMailer
    def export_ffa_chapter_email(user, subject = "Exported FFA Chapter", csv_content)
      subject = "#{subject} from staging" if ENV['APPLICATION_ENV'] == 'staging'
      attachments["FfaChapter-#{Date.today.to_s}.csv"] = {mime_type: 'text/csv', content: csv_content}
      mail(to: user.email, from: 'hello@agzaga.com', subject: subject)
    end

    def cancel_ffa_chapter_export_email(user, subject = "Exported FFA Chapter", csv_content)
      subject = "#{subject} from staging" if ENV['APPLICATION_ENV'] == 'staging'
      mail(to: user.email, from: 'hello@agzaga.com', subject: subject)
    end
  end
end

# touched on 2025-05-22T23:27:02.693091Z