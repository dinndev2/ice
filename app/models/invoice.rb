class Invoice < ApplicationRecord
  validates :details, :name, presence: true
  has_many :line_expences, dependent: :destroy, inverse_of: :invoice

  accepts_nested_attributes_for :line_expences, allow_destroy: true
end
