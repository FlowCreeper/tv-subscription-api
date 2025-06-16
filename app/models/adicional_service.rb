class AdicionalService < ApplicationRecord
  # Link to Subscriptions
  has_many :subscription_adicional_services
  has_many :subscriptions, through: :subscription_adicional_services

  # Link to Packages
  has_many :package_adicional_services
  has_many :packages, through: :package_adicional_services

  # Validates if the AdicionalService object has name and age
  validates :name, presence: true
  validates :price, presence: true,
    numericality: { greater_than_or_equal_to: 0 } # Blocks negative prices
end
