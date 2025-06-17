class Package < ApplicationRecord
  # Link to Subscriptions
  has_many :subscriptions

  # Link to exactly one Plan
  belongs_to :plan

  # Link to AdicionalServices
  has_many :package_adicional_services
  has_many :adicional_services, through: :package_adicional_services

  # Validates that there is a name and one plan
  validates :name, presence: true
  validates :plan, presence: true

  # Verify if the price is not negative and let it be blank so we can calc after
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  before_validation :set_default_price

  private

  # Set the price to the sum of plan and additional services if it is not present
  def set_default_price
    if price.blank?
      self.price = plan.price + adicional_services.sum(&:price)
    end
  end
end
