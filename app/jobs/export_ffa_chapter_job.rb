class ExportFfaChapterJob < ApplicationJob
  queue_as :default

  def perform(user)
    csv_content = CSV.generate( headers: true ) do |csv|
      @csv = csv
      add_header

      Spree::FfaChapter.all.each do |ffa_chapter|
        add_ffa_chapter_enrollments(ffa_chapter)
      end
    end

    if csv_content.present?
      Spree::ExportFfaChapterMailer.export_ffa_chapter_email(user, 'Exported FFA Chapter', csv_content).deliver_now
    else
      Spree::ExportFfaChapterMailer.cancel_ffa_chapter_export_email(user, 'Exported FFA Chapter', csv_content).deliver_now
    end
  end

  private

  def add_header
    @csv << [ 'First Name', 'Last Name', 'Email', 'Phone Number',
              'Chapter Name', 'Chapter Number', 'No of members', 'EIN Number',
              'School Name', 'Street Address', 'City', 'State', 'Postal Code',
              'Digital Signature', 'Consent Verified', 'Advisor Form Downloaded', 'Selected', 'Agreement Signed'
            ]
  end

  def add_ffa_chapter_enrollments ffa_chapter
      @csv << [ ffa_chapter.first_name, ffa_chapter.last_name, ffa_chapter.email, ffa_chapter.phone_number,
                ffa_chapter.name, ffa_chapter.number, ffa_chapter.members, ffa_chapter.ein_number,
                ffa_chapter.school_name, ffa_chapter.street, ffa_chapter.city, ffa_chapter.state, ffa_chapter.postal_code,
                ffa_chapter.digital_signature, ffa_chapter.consent_verified,
                ffa_chapter.advisor_form_downloaded, ffa_chapter.selected, ffa_chapter.is_signed
             ]
  end
end

# touched on 2025-05-22T19:24:41.536202Z
# touched on 2025-05-22T23:28:43.825880Z
# touched on 2025-05-22T23:30:14.454093Z