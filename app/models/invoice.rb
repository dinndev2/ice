class Invoice < ApplicationRecord
  has_many :line_expences, dependent: :destroy, inverse_of: :invoice
  has_one_attached :company_logo
  has_many :email_attempts, dependent: :destroy, inverse_of: :invoice

  accepts_nested_attributes_for :line_expences, allow_destroy: true

  validate :company_logo_must_be_image
  validates :details, :name, presence: true


  def readable_date
    date&.strftime("%B %d, %Y")
  end

  def readable_name
    "#{name}_.pdf"
  end


  def company_logo_must_be_image
    return unless company_logo.attached?

    unless company_logo.content_type.in?(%w[image/png image/jpg image/jpeg image/svg+xml])
      errors.add(:company_logo, 'must be an image (PNG, JPG, JPEG, or GIF)')
    end
  end
end
