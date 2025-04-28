class LineExpence < ApplicationRecord
  belongs_to :invoice, inverse_of: :line_expences
end
