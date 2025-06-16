class Customer < ApplicationRecord
  # Link to Subscription
  has_many :subscriptions

  # Validates if the Customer object has name and age
  validates :name, presence: true
  validates :age, presence: true,
    numericality:
      { greater_than_or_equal_to: 18 } # Validates if the Customer Age is greater or equal to 18
end
