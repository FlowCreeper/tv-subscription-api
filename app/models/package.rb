class Package < ApplicationRecord
  # Link to Subscriptions
  has_many :subscription_packages
  has_many :subscriptions, through: :subscription_packages

  # Link to Plans
  has_many :package_plans
  has_many :plans, through: :package_plans

  # Link to AdicionalServices
  has_many :package_adicional_services
  has_many :adicional_services, through: :package_adicional_services

  # Validates that there is a name and at least one plan
  validates :name, presence: true
  validates :plans, presence: true
  # Verify if the price is not negative and let it be blank so we can calc after
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  before_validation :set_default_price

  private
  # Set the price to the sum of plans and additional services if it is not present
  def set_default_price
    if price.blank?
      self.price = plans.sum(&:price) + adicional_services.sum(&:price)
    end
  end
end
