# frozen_string_literal: true

module Spree
  class StoreCreditWinner < Spree::Base
    validates :name, presence: true, format: {with: /\A[A-Za-z ]+\z/, message: 'Only alphabets are allowed'}
    validates :phone_number,format: { with: /\A\(?\d{3}\)?[- ]?\d{3}[- ]?\d{4}\z/,
    message: "Invalid, It should be in the format (XXX)XXX-XXXX"}, uniqueness: true
    validates :email, presence: true, format: {with: URI::MailTo::EMAIL_REGEXP,
      message: "Enter valid Email address."}, uniqueness: true
  end
end

# touched on 2025-05-22T19:20:29.579729Z
# touched on 2025-05-22T20:41:14.915596Z
# touched on 2025-05-22T21:19:05.673231Z
# touched on 2025-05-22T21:21:23.084621Z
# touched on 2025-05-22T22:34:51.843600Z
# touched on 2025-05-22T23:06:08.975353Z
# touched on 2025-05-22T23:42:21.018848Z