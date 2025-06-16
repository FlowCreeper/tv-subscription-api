class Invoice < ApplicationRecord
  belongs_to :subscription

  validates :due_date, :amount, presence: true
end
