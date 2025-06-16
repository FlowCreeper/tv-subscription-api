class Plan < ApplicationRecord
  # Link to Packages
  has_many :package_plans
  has_many :packages, through: :package_plans

  # Validates if the Plan object has name and age
  validates :name, presence: true
  validates :price, presence: true,
    numericality: { greater_than_or_equal_to: 0 } # Blocks negative prices
end
