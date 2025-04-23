class LineExpence < ApplicationRecord
  belongs_to :invoice, inverse_of: :line_expences

  validates :name, :quantity, :rate, presence: true
end
