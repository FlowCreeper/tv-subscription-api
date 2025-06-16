class SubscriptionPackage < ApplicationRecord
  belongs_to :subscription
  belongs_to :package
end
