class EmailAttempt < ApplicationRecord
  belongs_to :invoice, inverse_of: :email_attempts

  VALID_EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\z/

  validates :recipient, presence: true,
                    format: { with: VALID_EMAIL_REGEX, message: "must be a valid email address" }
end
