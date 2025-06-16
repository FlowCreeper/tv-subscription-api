class SubscriptionAdicionalService < ApplicationRecord
  belongs_to :subscription
  belongs_to :adicional_service
end
