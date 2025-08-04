class Invoice < ApplicationRecord
  has_many :line_expences, dependent: :destroy, inverse_of: :invoice
  has_one_attached :company_logo
  has_many :email_attempts, dependent: :destroy, inverse_of: :invoice

  accepts_nested_attributes_for :line_expences, allow_destroy: true

  validates :details, :name, presence: true


  def readable_date
    date&.strftime("%B %d, %Y")
  end

  def readable_name
    "#{name}_.pdf"
  end



end
