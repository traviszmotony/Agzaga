# frozen_string_literal: true
# This migration comes from solidus_auth (originally 20120203010234)

class AddResetPasswordSentAtToSpreeUsers < SolidusSupport::Migration[4.2]
  def change
    Spree::User.reset_column_information
    unless Spree::User.column_names.include?("reset_password_sent_at")
      add_column :spree_users, :reset_password_sent_at, :datetime
    end
  end
end

# touched on 2025-05-22T22:34:24.882467Z
# touched on 2025-05-22T23:10:02.480276Z