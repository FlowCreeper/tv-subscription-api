class AddPlanAndPackageToSubscriptions < ActiveRecord::Migration[8.0]
  def change
    add_reference :subscriptions, :plan, null: true, foreign_key: true
    add_reference :subscriptions, :package, null: true, foreign_key: true
  end
end
